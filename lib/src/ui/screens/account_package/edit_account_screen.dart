import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/profile/profile_bloc.dart';
import 'package:hand_bill/src/blocs/profile/profile_event.dart';
import 'package:hand_bill/src/blocs/profile/profile_state.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/custom/custom_icon_btn.dart';
import 'package:hand_bill/src/ui/component/custom/custom_text_filed_enter.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/account_package/account_screen.dart';
import 'package:hand_bill/src/ui/screens/common/image_full_screen.dart';
import 'package:image_picker/image_picker.dart';

class EditAccountScreen extends StatefulWidget {
  static const routeName = "/editAccountScreen";

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late double imgSize;
  late double marginVer;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState>? _profileFormKey;
  GlobalKey<FormState>? _passwordFormKey;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userNameArController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  User? _user;
  // Object? _userImage;

  final ImagePicker _picker = ImagePicker();
  List<Object> _images = [];
  bool loadingProfile = false, loadingPassword = false;

  ProfileBloc? _profileBloc ;
  @override
  void didChangeDependencies() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    super.didChangeDependencies();
  }
  @override
  void initState() {
    _profileFormKey = new GlobalKey<FormState>();
    _passwordFormKey = new GlobalKey<FormState>();
    // _currentPasswordController.text = "1234567";
    // _newPasswordController.text = "123456";
    _images.add(imageEx);
    getData();
    super.initState();
  }

  void getData() async {
    _user = BlocProvider.of<GlobalBloc>(context).user;
    log("${jsonEncode(_user)}");
    if (_user != null) {
      _userNameController.text = _user!.name!;
      _phoneController.text = _user!.phone ?? "";
      _addressController.text = _user!.address ?? "";
      print(_addressController.text);
      print(_phoneController.text);
    //
    }
  }


  @override
  void dispose() {
    _userNameController.dispose();
    // _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }


  File? image;
  Future<void> getImage() async {
    // if (_maxImages > _images.length) {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    image = File(pickedFile!.path);
    setState(() {
      // _images.add(image!);
    });
    // } else {
    //   Fluttertoast.showToast(msg: "max images is $_maxImages");
    // }
  }


  @override
  Widget build(BuildContext context) {
    _onEditProfileButtonPress() {
      if (_profileFormKey!.currentState!.validate()) {
        setState(() => loadingProfile = true);
        User user = User(
            apiToken: _user!.apiToken,
            name: _userNameController.text.trim(),
            phone: _phoneController.text.trim(),
            address: _addressController.text.trim());
        _profileBloc!.add(EditProfileEvent(user: user, image: image));
      }
    }

    _onEditPasswordButtonPress() {
      if (_passwordFormKey!.currentState!.validate()) {
        _profileBloc!.add(ChangePasswordEvent(
            user: _user,
            currentPassword: _currentPasswordController.text.trim(),
            newPassword: _newPasswordController.text.trim()));
      }
    }

    onImageTap(User user) {
      Navigator.pushNamed(context, ImageFullScreen.routeName,
          arguments: RouteArgument(param: APIData.domainLink+user.image!.url!));
    }

    marginVer = MediaQuery.of(context).size.height * 0.025;
    imgSize = MediaQuery.of(context).size.width * 0.27;
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
        appBar: RegularAppBar(label: "Account_information".tr()),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccessState) {
              setState(() => loadingProfile = false);
              Fluttertoast.showToast(
                  msg: state.message ?? '',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            } else if (state is EditProfileErrorState) {
              setState(() => loadingProfile = false);
              Fluttertoast.showToast(
                  msg: state.error ?? '',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

            }

            if (state is ChangePasswordSuccessState) {
              Fluttertoast.showToast(
                  msg: state.message ?? '',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              setState(() => loadingPassword = false);
            }
          },
          child: RefreshIndicator(
              onRefresh: () async {
                _userNameController.clear();
                _phoneController.clear();
                _addressController.clear();
                // _emailController.clear();
                setState(() {
                  if (_user != null) {
                    _userNameController.text = _user!.name!;
                    _phoneController.text = _user!.phone!;
                    _addressController.text = _user!.address!;
                  }
                });
              },
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: marginVer),
                        Stack(children: [
                          InkWell(
                              onTap: () => onImageTap(_user!),
                              child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: imgSize,
                                  height: imgSize,
                                  margin: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Color(0xffe0e0e0),
                                      borderRadius:
                                          BorderRadius.circular(9000)),
                                  child: image == null
                                      ? CachedNetworkImage(
                                          imageUrl: _user!.image == null
                                              ? placeholderLogo
                                              : _user!.image!.url!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Transform.scale(
                                                  scale: 0.4,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color:
                                                              mainColorLite)),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error,
                                                  color: mainColorLite))
                                      : Image.file(image!, fit: BoxFit.cover))),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CustomIconButton(
                                  iconColor: mainColor,
                                  backgroundColor: Colors.white,
                                  radius: 900,
                                  icon: Icons.camera_alt_outlined,
                                  padding: 6,
                                  press: () => getImage()))
                        ]),
                        Padding(
                            padding: EdgeInsets.fromLTRB(24, marginVer, 24, 0),
                            child: Form(
                                key: _profileFormKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _editLabel(label: "Name".tr()),
                                      CustomTextFormFieldtitle(
                                          controller: _userNameController,
                                          hintText: "Enter_name".tr(),
                                          validator: (input) {
                                            if (input.toString().length < 4) {
                                              return "name_is_short".tr();
                                            }
                                            return null;
                                          }),
                                      _editLabel(label: "NameAr".tr()),
                                      CustomTextFormFieldtitle(
                                          controller: _userNameArController,
                                          hintText: "Enter_name".tr(),
                                          validator: (input) {
                                            if (input.toString().length < 4) {
                                              return "name_is_short".tr();
                                            }
                                            return null;
                                          }),
                                      _editLabel(label: "phone".tr()),
                                      CustomTextFormFieldtitle(
                                          controller: _phoneController,
                                          hintText: "Enter_phone".tr(),
                                          validator: (input) {
                                            if (input.toString().length < 8) {
                                              return "phone_is_short".tr();
                                            }
                                            return null;
                                          }),
                                      _editLabel(label: "Country".tr()),
                                      CustomTextFormFieldtitle(
                                          controller: _addressController,
                                          hintText: "Enter_country".tr(),
                                          validator: (input) {
                                            if (input.toString().length < 3) {
                                              return "Enter_country".tr();
                                            }
                                            return null;
                                          }),
                                    ]))),
                        loadingProfile == false
                            ? SizedBox(height: marginVer * 1.5)
                            : Container(
                                height: 100,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: marginVer),
                                      CircularProgressIndicator(
                                          color: Theme.of(context).accentColor,
                                          strokeWidth: 2)
                                    ])),
                        CustomButton(
                            title: "Save_Profile".tr(),
                            radius: 900,
                            width: size.width * 0.7,
                            textStyle: TextStyle(fontWeight: FontWeight.w500),
                            onPress: () {
                              _onEditProfileButtonPress();
                            }),
                        SizedBox(height: marginVer * 0.5),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: marginVer),
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                border: Border.symmetric(
                                    horizontal:
                                        BorderSide(color: Color(0xffe0e0e0))))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Form(
                                key: _passwordFormKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _editLabel(label: "password".tr()),
                                      CustomTextFormFieldtitle(
                                          controller:
                                              _currentPasswordController,
                                          hintText: "enter_password".tr(),
                                          validator: (input) {
                                            if (input.toString().length < 6) {
                                              return "password_is_short".tr();
                                            }
                                            return null;
                                          }),
                                      _editLabel(label: "new_password".tr()),
                                      CustomTextFormFieldtitle(
                                          controller: _newPasswordController,
                                          hintText: "Enter_new_password".tr(),
                                          validator: (input) {
                                            if (input.toString().length < 6) {
                                              return "password_is_short".tr();
                                            }
                                            return null;
                                          }),
                                      SizedBox(height: marginVer * 2),
                                    ]))),
                        loadingPassword == false
                            ? SizedBox()
                            : Container(
                                height: 100,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: marginVer),
                                      CircularProgressIndicator(
                                          color: Theme.of(context).accentColor,
                                          strokeWidth: 2)
                                    ])),
                        CustomButton(
                            title: "Save_password".tr(),
                            radius: 900,
                            width: size.width * 0.7,
                            textStyle: TextStyle(fontWeight: FontWeight.w500),
                            onPress: () {
                              _onEditPasswordButtonPress();
                            }),
                        SizedBox(height: 80)
                      ]))),
        ));
  }

  Widget _editLabel({required String label}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(12, 12, 6, 6),
        child: Text(label,
            style: TextStyle(
              // fontSize: 13,
              color: Color(0xff3c63fe),
              // color: Colors.black,
              fontWeight: FontWeight.w500,
            )));
  }
}
