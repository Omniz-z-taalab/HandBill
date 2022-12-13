import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_bloc.dart';
import 'package:hand_bill/src/blocs/patents/patents_event.dart';
import 'package:hand_bill/src/blocs/patents/patents_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/patented_model.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/custom/custom_text_filed_enter.dart';
import 'package:hand_bill/src/ui/component/custom/image_widget.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PatentedAddScreen extends StatefulWidget {
  static const routeName = "/PatentedAddScreen";
  final RouteArgument? routeArgument;

  PatentedAddScreen({this.routeArgument});

  @override
  _PatentedAddScreenState createState() => _PatentedAddScreenState();
}

class _PatentedAddScreenState extends State<PatentedAddScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  late PatentedModel _model;
  final ImagePicker _picker = ImagePicker();
  int _maxImages = 1;
  List<Object> _images = [];
  int _imageIndex = 0;

  double _radius = 8;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState>? _formKey;
  late PatentsBloc _patentsBloc;
  late User? _user;

  bool _loading = false;

  @override
  void initState() {
    _patentsBloc = BlocProvider.of<PatentsBloc>(context);
    _user = BlocProvider.of<GlobalBloc>(context).user;
    _formKey = new GlobalKey<FormState>();
    if (widget.routeArgument != null) {
      _model = widget.routeArgument!.param;
      _titleController.text = _model.title!;
      _descriptionController.text = _model.description!;
      _images.addAll(_model.image!);
    } else {
      _model = PatentedModel();
      // _titleController.text = "New Patented";
      // _descriptionController.text =
      //     "Description Description Description Description Description";
    }
    super.initState();
  }

  Future<void> getImage() async {
    File? image;
    if (_maxImages > _images.length) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      image = File(pickedFile!.path);
      setState(() {
        _images.add(image!);
      });
    } else {
      Fluttertoast.showToast(msg: "${"max_images_is".tr()} ${_maxImages}");
    }
  }

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _onAddButtonPressed() {
      if (_user == null) {
        Fluttertoast.showToast(
            msg:  'Login first'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else if (_formKey!.currentState!.validate()) {
        _model.title = _titleController.text;
        _model.description = _descriptionController.text;
        _patentsBloc.add(
            PatentedAddEvent(model: _model, user: _user!, images: _images));
        _loading = true;
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(
            label: _model.id == null ? "AddPatented".tr() : "Edit Patented"),
        body: BlocBuilder<PatentsBloc, PatentsState>(builder: (context, state) {
          if (state is PatentsErrorState) {
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              displaySnackBar(title: state.error!, scaffoldKey: _scaffoldKey);
            });
            _loading = false;
          }
          if (state is PatentedAddSuccessState) {
            Fluttertoast.showToast(
                msg: state.message ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pop(context);
            _images.clear();
            _titleController.clear();
            _descriptionController.clear();
            _loading = false;
          }

          return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _images.length == 0
                        ? SizedBox()
                        : Stack(children: [
                            Container(
                                height: size.height * 0.3,
                                width: double.infinity,
                                child: PageView.builder(
                                    itemCount: _images.length,
                                    controller:
                                        PageController(viewportFraction: 1),
                                    onPageChanged: (int index) {
                                      setState(() => _imageIndex = index);
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (_images[index] is String) {
                                        return ServerImageWidget(
                                            image: _images[index].toString(),
                                            // onTap: () => getImage(index),
                                            onRemoveTap: () =>
                                                removeImage(index));
                                      }
                                      if (_images[index] is File) {
                                        return LocalImageWidget(
                                            image: _images[index] as File,
                                            // onTap: () => getImage(index),
                                            onRemoveTap: () =>
                                                removeImage(index));
                                      }
                                      return SizedBox();
                                    })),
                            Positioned(
                                bottom: 8,
                                right: 0,
                                left: 0,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DotsIndicator(
                                          dotsCount: _images.length,
                                          position: _imageIndex.toDouble(),
                                          decorator: DotsDecorator(
                                              color: Color(0x4DFFFFFF),
                                              activeColor: Color(0xB3FFFFFF),
                                              size: const Size.square(4.0),
                                              activeSize: const Size(10.0, 4.0),
                                              activeShape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0))))
                                    ])),
                          ]),
                    SizedBox(height: 16),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: _jobLabel(label: "Images".tr())),
                    SizedBox(height: 16),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () => getImage(),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      decoration: BoxDecoration(
                                          color: Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(_radius),
                                          border: Border.all(
                                              color: Color(0xffeeeeee))),
                                      child: Row(children: [
                                        Icon(Icons.add_photo_alternate_outlined,
                                            color: mainColorLite),
                                        SizedBox(width: 12),
                                        Text(
                                            "Add Image".tr(),
                                            style:
                                                TextStyle(color: textDarkColor)),
                                        Text(
          " ${(_images.length)}/$_maxImages ",
                                            style:
                                                TextStyle(color: textDarkColor))
                                      ])))
                            ])),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 16),
                                  _jobLabel(label: "title".tr()),
                                  SizedBox(height: 16),
                                  CustomTextFormFieldtitle(
                                      controller: _titleController,
                                      hintText: "Enter_title".tr(),
                                      validator: (input) {
                                        if (input.toString().length < 4) {
                                          return "title is short".tr();
                                        }
                                        return null;
                                      }),
                                  SizedBox(height: 16),
                                  _jobLabel(label: "Description".tr()),
                                  SizedBox(height: 16),
                                  CustomTextFormFieldEnter(
                                      controller: _descriptionController,
                                      hintText: "Enter description".tr(),
                                      validator: (input) {
                                        if (input.toString().length < 4) {
                                          return "description is short".tr();
                                        }
                                        return null;
                                      }),
                                ]))),
                    _loading == false
                        ? SizedBox(height: 40)
                        : Container(
                            height: 100,
                            width: double.infinity,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 16),
                                  CircularProgressIndicator(
                                      color: Theme.of(context).accentColor,
                                      strokeWidth: 2)
                                ])),
                    SizedBox(height: 40),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CustomButton(
                          title: _model.id == null ? "Add".tr() : "Edit",
                          width: size.width * 0.7,
                          radius: 900,
                          onPress: () {
                            _onAddButtonPressed();
                          })
                    ]),
                    SizedBox(height: 80)
                  ]));
        }));
  }

  Widget _jobLabel({required String label}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }
}
