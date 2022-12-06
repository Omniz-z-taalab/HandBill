import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/job/job_bloc.dart';
import 'package:hand_bill/src/blocs/job/job_event.dart';
import 'package:hand_bill/src/blocs/job/job_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/job_category_model.dart';
import 'package:hand_bill/src/data/model/services/job_company_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/component/job_company_widget.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/my_jobs_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

class CompaniesJobsScreen extends StatefulWidget {
  static const routeName = "/JobsScreen";

  @override
  _CompaniesJobsScreenState createState() => _CompaniesJobsScreenState();
}

class _CompaniesJobsScreenState extends State<CompaniesJobsScreen> {
  List<JobCompanyModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late JobsBloc _jobsBloc;
  User? _user;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  List<JobCategoryModel> _categories = [];
  List<JobCategoryModel> _subcategories = [];

  late JobCategoryModel _jobCategoryModel;
  late JobCategoryModel _jobSubCategoryModel;

  @override
  void initState() {
    _jobsBloc = BlocProvider.of<JobsBloc>(context);
    _jobsBloc.allPage = 1;
    _scrollController = ScrollController()..addListener(_onScroll);
    _user = BlocProvider.of<GlobalBloc>(context).user;

    _jobsBloc.add(FetchCompaniesJobsEvent());
    _jobsBloc.add(FetchJobsCategoriesEvent());
    _jobCategoryModel = JobCategoryModel(id: 0, name: "category");
    _jobSubCategoryModel = JobCategoryModel(id: 0, name: "subcategory");
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  void _onScroll() {
    final max = _scrollController!.position.maxScrollExtent;
    final offset = _scrollController!.offset;

    if (offset + offsetVisibleThreshold >= max && !_jobsBloc.isFetching) {
      setState(() {
        _jobsBloc.isFetching = true;
      });
      _jobsBloc.add(FetchCompaniesJobsEvent());
    }
  }

  double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xfff5f5f5),
        appBar: RegularAppBar(
            label: "jobs".tr(),
            widget: InkWell(
                onTap: () {
                  if (_user == null) {
                    Fluttertoast.showToast(
                        msg:  'Login first'.tr(),
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  } else {
                    Navigator.pushNamed(context, MyJobsScreen.routeName);
                  }
                },
                child: Icon(Icons.add))),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                _items!.clear();
                _items = null;
              }
              _jobsBloc.allPage = 1;
              _jobsBloc.add(FetchCompaniesJobsEvent());
            },
            child:
                BlocConsumer<JobsBloc, JobsState>(listener: (context, state) {
              if (state is CompanyJobSuccessState) {
                _items = state.items;
              }

              if (state is JobCategoriesSuccessState) {
                _categories.addAll(state.items!);
                loading = false;
              }
              if (state is JobSubcategoriesSuccessState) {
                _subcategories.addAll(state.items!);
                loading = false;
              }
            }, builder: (context, state) {
              return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    _items == null
                        ? LoadingSliver()
                        : _items!.length == 0
                            ? CenterWidgetListSliver(label: "Jobs is empty")
                            : SliverToBoxAdapter(
                                child: SizedBox(
                                height: 700,
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: _items!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return JobCompanyWidget(
                                          model: _items![index]);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                                height: 10,
                                                color: Color(0xffeeeeee))),
                              )),
                    SliverToBoxAdapter(child: SizedBox(height: 100)),
                    SliverToBoxAdapter(
                        child: Container(
                            child: loading == true
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2)))
                                : SizedBox()))
                  ]);
            })),
        bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              color: Colors.white,
              child: Row(children: [
                _widget(
                    label: _jobCategoryModel.name!,
                    onTap: () => _selectCategory()),
                Container(height: 16, width: 1, color: mainColorLite),
                _widget(
                    label: _jobSubCategoryModel.name!,
                    onTap: () => _selectSubcategory())
              ]))
        ]));
  }

  Widget _widget({required String label, required Function onTap}) {
    return Expanded(
        child: InkWell(
            onTap: () => onTap(),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(label,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textDarkColor))
                    ]))));
  }

  void _selectCategory() {
    showDialog(
        context: context,
        builder: (context) => MyForm(
            onSubmit: onSubmitCategory, items: _categories, label: "Category"));
  }

  void _selectSubcategory() {
    showDialog(
        context: context,
        builder: (context) => MyForm(
            onSubmit: onSubmitSubCategory,
            items: _subcategories,
            label: "Subcategory"));
  }

  void onSubmitCategory(JobCategoryModel model) {
    setState(() {
      _jobCategoryModel = model;
      _jobSubCategoryModel =
          JobCategoryModel(id: 0, name: "Select job subcategory");
      _subcategories.clear();
      _jobsBloc.add(FetchJobsSubcategoriesEvent(id: model.id!));
    });
  }

  void onSubmitSubCategory(JobCategoryModel model) {
    setState(() {
      _jobSubCategoryModel = model;
      if (_items != null) {
        _items!.clear();
      }
    });
    _jobsBloc.allPage = 1;
    _jobsBloc
      .add(FetchCompaniesJobsEvent(
          categoryId: _jobCategoryModel.id,
          subcategoryId: _jobSubCategoryModel.id));
  }
}

typedef void MyFormCallback(JobCategoryModel result);

class MyForm extends StatefulWidget {
  final MyFormCallback onSubmit;
  List<JobCategoryModel> items;
  String label;

  MyForm({required this.onSubmit, required this.items, required this.label});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
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
            itemBuilder: (context, index) {
              return RadioListTile(
                value: index,
                groupValue: value,
                onChanged: (int? ind) => setState(() {
                  value = ind!;
                  Navigator.pop(context);
                  widget.onSubmit(widget.items[value!]);
                }),
                title: Text(widget.items[index].name ?? "name"),
              );
            }),
      ),
    );
  }
}
