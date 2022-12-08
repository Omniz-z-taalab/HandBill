import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/job/job_bloc.dart';
import 'package:hand_bill/src/blocs/job/job_event.dart';
import 'package:hand_bill/src/blocs/job/job_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/job_category_model.dart';
import 'package:hand_bill/src/data/model/services/job_user_model.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/custom/custom_text_filed_enter.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';

class JobAddScreen extends StatefulWidget {
  static const routeName = "/JobAddScreen";
  final RouteArgument? routeArgument;

  JobAddScreen({this.routeArgument});

  @override
  _JobAddScreenState createState() => _JobAddScreenState();
}

class _JobAddScreenState extends State<JobAddScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  late JobUserModel _model;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState>? _formKey;
  late JobsBloc _jobsBloc;
  late User? _user;

  bool loading = false;

  late JobCategoryModel _jobCategoryModel;
  late JobCategoryModel _jobSubCategoryModel;

  List<JobCategoryModel> _categories = [];
  List<JobCategoryModel> _subcategories = [];

  @override
  void initState() {
    _jobsBloc = BlocProvider.of<JobsBloc>(context);
    _formKey = new GlobalKey<FormState>();

    _user = BlocProvider.of<GlobalBloc>(context).user;
    _jobsBloc.add(FetchJobsCategoriesEvent());

    if (widget.routeArgument != null) {
      _model = widget.routeArgument!.param;
      _jobCategoryModel = _model.jobCategoryModel!;
      _jobSubCategoryModel = _model.jobSubCategoryModel!;
      _titleController.text = _model.title!;
      _descriptionController.text = _model.description!;
    } else {
      _model = JobUserModel();
      _jobCategoryModel = JobCategoryModel(id: 0, name: "Select job category".tr());
      _jobSubCategoryModel =
          JobCategoryModel(id: 0, name: "Select job subcategory".tr());
      // _titleController.text = "senior prof";
      // _descriptionController.text = "1+ years of experience";
    }
    super.initState();
  }

  getUser() {
    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      print("nnnnnnn ${_user!.name}");
    }
  }

  Color _borderColor = Color(0xffeeeeee);

  void onSubmitCategory(JobCategoryModel model) {
    setState(() {
      _jobCategoryModel = model;
      _jobSubCategoryModel =
          JobCategoryModel(id: 0, name: "Select job subcategory".tr());
      _subcategories.clear();
      _jobsBloc.add(FetchJobsSubcategoriesEvent(id: model.id!));
    });
  }

  void onSubmitSubCategory(JobCategoryModel model) {
    setState(() {
      _jobSubCategoryModel = model;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar:
            RegularAppBar(label: _model.id == null ? "Add Job".tr() : "Edit Job"),
        body: BlocBuilder<JobsBloc, JobsState>(builder: (context, state) {
          if (state is JobLoadingState) {
            loading = true;
          }
          if (state is JobErrorState) {
            Fluttertoast.showToast(
                msg: state.error ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
              loading = false;
          }
          if (state is JobAddSuccessState) {

            Fluttertoast.showToast(
                msg: state.message ?? '',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            _jobCategoryModel =
                JobCategoryModel(id: 0, name: "Select job category");
            JobCategoryModel(id: 0, name: "Select job subcategory");
            _titleController.clear();
            _descriptionController.clear();
            loading = false;
          }
          if (state is JobCategoriesSuccessState) {
            _categories.addAll(state.items!);
            loading = false;
          }
          if (state is JobSubcategoriesSuccessState) {
            _subcategories.addAll(state.items!);
            loading = false;
          }

          return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _jobLabel(label: "Category".tr()),
                          SizedBox(height: 16),
                          InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => MyForm(
                                        label: "Category".tr(),
                                        onSubmit: onSubmitCategory,
                                        items: _categories));
                              },
                              child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: _borderColor)),
                                  child: Text(_jobCategoryModel.name!,
                                      style: TextStyle(
                                          color: textDarkColor,
                                          fontSize: 16)))),
                          SizedBox(height: 16),
                          _jobLabel(label: "Subcategory".tr()),
                          SizedBox(height: 16),
                          InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => MyForm(
                                        label: "Subcategory".tr(),
                                        onSubmit: onSubmitSubCategory,
                                        items: _subcategories));
                              },
                              child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: _borderColor)),
                                  child: Text(_jobSubCategoryModel.name!,
                                      style: TextStyle(
                                          color: textDarkColor,
                                          fontSize: 16)))),
                          SizedBox(height: 16),
                          _jobLabel(label: "title".tr()),
                          SizedBox(height: 16),
                          Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextFormFieldEnter(
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
                                        })
                                  ]))
                        ])),
                loading == false
                    ? SizedBox(height: 40)
                    : Container(
                        height: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 16),
                              CircularProgressIndicator(
                                  color: Theme.of(context).accentColor,
                                  strokeWidth: 2)
                            ])),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomButton(
                      title: _model.id == null ? "Add".tr() : "Edit",
                      width: size.width * 0.7,
                      radius: 900,
                      onPress: () {
                        _onAddButtonPressed();
                      })
                ]),
                SizedBox(height: 80),
              ]));
        }));
  }

  void _onAddButtonPressed() {
    if (_formKey!.currentState!.validate()) {
      if (!_user!.profileCompleted()) {
        Fluttertoast.showToast(
            msg: 'Complete your profile'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else if (_jobCategoryModel.id == 0) {
        Fluttertoast.showToast(
            msg: 'Select job category'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

      } else if (_jobSubCategoryModel.id == 0) {
        Fluttertoast.showToast(
            msg: 'Select job subcategory'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _model.title = _titleController.text;
        _model.description = _descriptionController.text;
        _model.jobCategoryModel = _jobCategoryModel;
        _model.jobSubCategoryModel = _jobSubCategoryModel;
        _jobsBloc.add(JobAddEvent(model: _model, user: _user!));
      }
    }
  }

  Widget _jobLabel({required String label}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(label,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }
}

typedef void MyFormCallback(JobCategoryModel result);

class MyForm extends StatefulWidget {
  final MyFormCallback onSubmit;
  List<JobCategoryModel> items;
  String label;

  MyForm({required this.onSubmit, required this.items, required this.label});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  int? value;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.label),
        content: SizedBox(
          height: 500,
          width: 300,
          child: ListView.builder(
              itemCount: widget.items.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: index,
                  groupValue: value,
                  onChanged: (int? ind) => setState(() {
                    value = ind!;
                    Navigator.pop(context);
                    widget.onSubmit(widget.items[value!]);
                  }),
                  title: Text(widget.items[index].name ?? "Name".tr(),
                  ) );
              }),
        ));
  }
}
