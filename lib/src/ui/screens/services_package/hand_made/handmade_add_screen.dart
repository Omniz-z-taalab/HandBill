import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_bloc.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_event.dart';
import 'package:hand_bill/src/blocs/hand_made/hand_made_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/services/handmade_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/custom/custom_text_filed_enter.dart';
import 'package:hand_bill/src/ui/component/custom/image_widget.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:image_picker/image_picker.dart';

class HandmadeAddScreen extends StatefulWidget {
  static const routeName = "/HandmadeAddScreen";
  final RouteArgument? routeArgument;

  HandmadeAddScreen({this.routeArgument});

  @override
  _HandmadeAddScreenState createState() => _HandmadeAddScreenState();
}

class _HandmadeAddScreenState extends State<HandmadeAddScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  late HandmadeModel _model;
  double _radius = 8;

  final ImagePicker _picker = ImagePicker();
  int _maxImages = 3;
  List<Object> _images = [];
  int _imageIndex = 0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState>? _formKey;
  late HandmadeBloc _handmadeBloc;
  late User? _user;

  bool loading = false;
  double marginVer = 16;

  @override
  void initState() {
    _handmadeBloc = BlocProvider.of<HandmadeBloc>(context);
    _formKey = new GlobalKey<FormState>();
    _user = BlocProvider.of<GlobalBloc>(context).user;

    if (widget.routeArgument != null) {
      _model = widget.routeArgument!.param;
      _titleController.text = _model.title!;
      _descriptionController.text = _model.description!;
      _priceController.text = _model.price.toString();
      _images.addAll(_model.images!);
    } else {
      _model = HandmadeModel();
      // _titleController.text = "jacket";
      // _descriptionController.text = "sliver jacket";
      // _priceController.text = "200";
    }

    super.initState();
  }
  File? image;

  Future<void> getImage() async {
    if (_maxImages > _images.length) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      image = File(pickedFile!.path);
      setState(() {
        _images.add(image!);
      });
    } else {
      Fluttertoast.showToast(msg: "max images is $_maxImages");
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
      if  (_formKey!.currentState!.validate()) {
        setState(() => loading = true);
        _model.title = _titleController.text;
        _model.description = _descriptionController.text;
        _model.price = _priceController.text;
        _handmadeBloc.add(
            HandmadeAddEvent(model: _model, user: _user!, images: _images));


      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: RegularAppBar(
            label: _model.id == null ? "Add Product" : "Edit Product"),
        body: BlocListener<HandmadeBloc, HandmadeState>(
            listener: (context, state) {
              if (state is HandmadeLoadingState) {
                loading = true;
              }
              if (state is HandmadeErrorState) {
                Fluttertoast.showToast(
                    msg: state.error ?? '',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                setState(() {
                  loading = false;
                });
              }
              if (state is HandmadeAddSuccessState) {
                Fluttertoast.showToast(
                    msg: state.message ?? '',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                setState(() {
                  loading = false;
                  Navigator.pop(context);

                });
              }
            },
            child: SingleChildScrollView(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DotsIndicator(
                                            dotsCount: _images.length,
                                            position: _imageIndex.toDouble(),
                                            decorator: DotsDecorator(
                                                color: Color(0x4DFFFFFF),
                                                activeColor: Color(0xB3FFFFFF),
                                                size: const Size.square(4.0),
                                                activeSize:
                                                    const Size(10.0, 4.0),
                                                activeShape:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    5.0))))
                                      ])),
                            ]),
                      SizedBox(height: 16),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: _jobLabel(label: "Images")),
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
                                          Icon(
                                              Icons
                                                  .add_photo_alternate_outlined,
                                              color: mainColorLite),
                                          SizedBox(width: 12),
                                          Text(
                                              "Add Image    ${(_images.length)}/$_maxImages ",
                                              style: TextStyle(
                                                  color: textDarkColor))
                                        ])))
                              ])),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(height: 16),
                                    _jobLabel(label: "Title"),
                                    SizedBox(height: 16),
                                    CustomTextFormFieldEnter(
                                        controller: _titleController,
                                        hintText: "Enter title",
                                        validator: (input) {
                                          if (input.toString().length < 4) {
                                            return "title is short";
                                          }
                                          return null;
                                        }),
                                    SizedBox(height: 16),
                                    _jobLabel(label: "Description"),
                                    SizedBox(height: 16),
                                    CustomTextFormFieldEnter(
                                        controller: _descriptionController,
                                        hintText: "Enter description",
                                        validator: (input) {
                                          if (input.toString().length < 4) {
                                            return "description is short";
                                          }
                                          return null;
                                        }),
                                    SizedBox(height: 16),
                                    _jobLabel(label: "Price"),
                                    SizedBox(height: 16),
                                    CustomTextFormFieldEnter(
                                        controller: _priceController,
                                        hintText: "Enter price",
                                        validator: (input) {
                                          if (input.toString().isEmpty) {
                                            return "enter price";
                                          }
                                          return null;
                                        }),
                                  ]))),
                      loading == false
                          ? SizedBox(height: 40)
                          : Container(
                              height: 100,
                              width: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: marginVer),
                                    CircularProgressIndicator(
                                        color: Theme.of(context).accentColor,
                                        strokeWidth: 2)
                                  ])),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(

                                title: _model.title == null ? "Add" : "Edit",
                                width: size.width * 0.7,
                                radius: 900,
                                onPress: () {
                                  _onAddButtonPressed();
                                })
                          ]),
                      SizedBox(height: 80),
                    ]))));
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
