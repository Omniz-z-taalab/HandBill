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
import 'package:hand_bill/src/data/model/services/job_user_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/jobs_add_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';

import 'component/job_user_widget.dart';

class MyJobsScreen extends StatefulWidget {
  static const routeName = "/MyJobsScreen";

  @override
  _MyJobsScreenState createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  List<JobUserModel>? _items;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late JobsBloc _jobsBloc;
  User? _user;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;

  @override
  void initState() {
    _jobsBloc = BlocProvider.of<JobsBloc>(context);
    _scrollController = ScrollController()..addListener(_onScroll);

    _user = BlocProvider.of<GlobalBloc>(context).user;
    if (_user != null) {
      _jobsBloc.myPage = 1;
      _jobsBloc.add(FetchMyJobsEvent(user: _user!));
    }

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
        // backgroundColor: Colors.white,
        appBar: RegularAppBar(label: "My Jobs".tr()),
        floatingActionButton: FloatingActionButton(
            backgroundColor: mainColorLite,
            onPressed: () {
              Navigator.pushNamed(context, JobAddScreen.routeName);
            },
            child: Icon(Icons.add)),
        body: RefreshIndicator(
            onRefresh: () async {
              if (_items != null) {
                _items!.clear();
                _items = null;
              }
              if (_user != null) {
                _jobsBloc.myPage = 1;
                _jobsBloc.add(FetchMyJobsEvent(user: _user!));
              }
            },
            child: BlocListener<JobsBloc, JobsState>(
                listener: (context, state) {
                  if (state is JobErrorState) {
                    _items = [];
                    SchedulerBinding.instance?.addPostFrameCallback((_) {
                      displaySnackBar(
                          title: state.error!, scaffoldKey: _scaffoldKey);
                    });
                  }
                  if (state is MyJobSuccessState) {
                    setState(() {
                      if (_items == null) {
                        _items = [];
                      }
                      _items!.addAll(state.items!);
                    });
                  }
                  if (state is JobRemoveSuccessState) {
                    Fluttertoast.showToast(
                        msg: state.message ?? '',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                    if (_items != null) {
                      setState(() {
                        _items!.removeWhere(
                            (element) => element.id == state.model.id);
                      });
                    }
                  }
                },
                child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      _items == null
                          ? LoadingSliver()
                          : _items!.length == 0
                              ? CenterWidgetListSliver(
                                  label: "Your Jobs is empty".tr())
                              : SliverToBoxAdapter(
                                  child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: _items!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return JobUserWidget(
                                            model: _items![index],
                                            onRemoveTap: () =>
                                                _deleteItem(_items![index]));
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Container(
                                                  height: 10,
                                                  color: Color(0xffeeeeee)))),
                      SliverToBoxAdapter(child: SizedBox(height: 100)),
                      SliverToBoxAdapter(
                          child: Container(
                              child: loading == true
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 40),
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2)))
                                  : SizedBox()))
                    ]))));
  }

  void _deleteItem(JobUserModel model) {
    _jobsBloc.add(JobRemoveEvent(user: _user!, model: model));
  }
}
