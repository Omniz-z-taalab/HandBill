import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_event.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_state.dart';
import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/category/sub_category.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/common/services_company_widget/customs_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_widget.dart';

import '../../../../data/model/local/route_argument.dart';
import '../../navigation_package/categories/component/sub_category_widget.dart';

class SubShipingScreen extends StatefulWidget {
  static const routeName = "/ShippingScreen";
  late final RouteArgument? routeArgument;

  SubShipingScreen({required this.routeArgument});

  @override
  _SubShipingScreenState createState() => _SubShipingScreenState();
}

class _SubShipingScreenState extends State<SubShipingScreen>
    with SingleTickerProviderStateMixin {
  List<Company>? _items;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late OtherCompanyBloc _otherCompanyBloc;
  ScrollController? _scrollController;
  static const offsetVisibleThreshold = 50.0;
  bool loading = false;
  List<String> companies = [
    "mtjm.shipping_clearance".tr(),
   "mtjm.contracting".tr(),
    "mtjm.tourism".tr(),
   "mtjm.petroleum".tr(),
    "mtjm.universities".tr(),
    "mtjm.hospitals".tr(),
    "mtjm.training_centers".tr(),
    "mtjm.consulting_offices".tr(),
    "mtjm.chartered_accountants".tr(),
    "mtjm.schools".tr(),
    "mtjm.not_found".tr(),
  ];
  String selectedCompanyKind = "mtjm.shipping_clearance".tr();

  String selectSubNatureValue = "shipping_clearance";
  setSubNature(String val) {
    setState(() {
      if (val == "mtjm.contracting".tr()) {
        selectSubNatureValue = "contracting";
      } else if (val == "mtjm.tourism".tr()) {
        selectSubNatureValue = "tourism";
      } else if (val == "mtjm.petroleum".tr()) {
        selectSubNatureValue = "petroleum";
      } else if (val == "mtjm.universities".tr()) {
        selectSubNatureValue = "universities";
      } else if (val == "mtjm.hospitals".tr()) {
        selectSubNatureValue = "hospitals";
      } else if (val == "mtjm.training_centers".tr()) {
        selectSubNatureValue = "training_centers";
      } else if (val == "mtjm.consulting_offices".tr()) {
        selectSubNatureValue = "consulting_offices";
      } else if (val == "mtjm.chartered_accountants".tr()) {
        selectSubNatureValue = "chartered_accountants";
      } else if (val == "mtjm.schools".tr()) {
        selectSubNatureValue = "schools";
      } else {
        selectSubNatureValue = "shipping_clearance";
      }
    });
    _otherCompanyBloc.shippingPage = 1;
    _otherCompanyBloc
      ..add(FetchShippingCompaniesEvent(subNature: selectSubNatureValue));
  }

  @override
  void initState() {
    _otherCompanyBloc = BlocProvider.of<OtherCompanyBloc>(context);
    _otherCompanyBloc.shippingPage = 1;
    _otherCompanyBloc
      ..add(FetchShippingCompaniesEvent(subNature: selectSubNatureValue));
    // _scrollController = ScrollController()..addListener(_onScroll);
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
    if (offset + offsetVisibleThreshold >= max &&
        !_otherCompanyBloc.isFetching) {
      setState(() {
        _otherCompanyBloc.isFetching = true;
      });
      _otherCompanyBloc
          .add(FetchShippingCompaniesEvent(subNature: selectSubNatureValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RegularAppBar(
          label: 'aaaa  ',
        ),
        backgroundColor: Color(0xfff5f5f5),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: BlocListener<OtherCompanyBloc, OtherCompanyState>(
              listener: (context, state) {
                if (state is OtherCompanyErrorState) {
                  _items = [];
                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    displaySnackBar(
                        title: state.error!, scaffoldKey: _scaffoldKey);
                  });
                }
                if (state is ShippingSuccessState) {
                  setState(() {
                    if (_items == null) {
                      _items = [];
                    }
                    // if(_items!.isNotEmpty){
                    //   _items = [];
                    //   _items!.forEach((element) {
                    //     if(element.subNatureActivity==selectSubNatureValue){
                    //       _items!.add(element);
                    //     }
                    //   });
                    // }
                    if (_items != null && _items!.isNotEmpty) {
                      _items!.clear();
                    }
                    _items!.addAll(state.items!);
                  });
                }
              },
              // child: ListView(children: [
              //   GridView.count(
              //       padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
              //       childAspectRatio: 1 / 0.7,
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 2,
              //       mainAxisSpacing: 2,
              //       shrinkWrap: true,
              //       primary: false,
              //       children: List.generate(companies.length, (index) {
              //         return CategoryWidget(
              //             model: CategoryModel(
              //               name: companies[index],
              //               selected: selectedCompanyKind == companies[index],
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 selectedCompanyKind = companies[index];
              //               });
              //             });
              //       })),
              //   SizedBox(height: 80),
              // ]),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        // Container(
                        //     padding: EdgeInsets.only(bottom: 40),
                        //     decoration: BoxDecoration(
                        //         color: Color(0xffffffff),
                        //         border: Border.symmetric(
                        //             vertical:
                        //                 BorderSide(color: Color(0xffeeeeee)))),
                        //     child: companies.isEmpty
                        //         ? ListView.builder(
                        //             shrinkWrap: true,
                        //             physics: BouncingScrollPhysics(),
                        //             itemCount: 6,
                        //             itemBuilder: (context, index) {
                        //               return CategoryEmptyWidget();
                        //             })
                        //         : SizedBox(
                        //             height: 70,
                        //             child: ListView.builder(
                        //                 scrollDirection: Axis.horizontal,
                        //                 shrinkWrap: true,
                        //                 physics: BouncingScrollPhysics(),
                        //                 itemCount: companies.length,
                        //                 itemBuilder: (context, index) {
                        //                   return CategoryWidget(
                        //                       model: CategoryModel(
                        //                         name: companies[index],
                        //                         selected: selectedCompanyKind ==
                        //                             companies[index],
                        //                       ),
                        //                       onTap: () {
                        //                         setState(() {
                        //                           selectedCompanyKind =
                        //                               companies[index];
                        //                         });
                        //                         setSubNature(companies[index]);
                        //                       });
                        //                   return CategoryEmptyWidget();
                        //                 }),
                        //           )),
                        _items != null && _items!.isNotEmpty
                            ? Container(
                                child: Column(children: [
                                  _items == null || _items!.length == 0
                                      ? CenterWidgetListSliver(
                                          label: "mtjm.not_found".tr())
                                      : ListView.separated(
                                          physics: BouncingScrollPhysics(),
                                          // padding: EdgeInsets.symmetric(vertical: 16),
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: _items!.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return CustomsWidget(
                                              model: _items![index],
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  Container(
                                                      height: 10,
                                                      color:
                                                          Color(0xffeeeeee))),
                                ]),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ])),
                ],
              )),
        ));
  }
}
