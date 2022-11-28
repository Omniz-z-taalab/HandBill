import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_translate/flutter_translate.dart';
import 'package:hand_bill/src/blocs/Services/bloc.dart';
import 'package:hand_bill/src/blocs/Services/states.dart';
// import 'package:hand_bill/src/blocs/other_company/other_company_state.dart';
// import 'package:hand_bill/src/data/model/category/category.dart';
import 'package:hand_bill/src/data/model/category/sub_category.dart';
// import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/serviceCategories_model.dart';
import 'package:hand_bill/src/data/response/banner/banner_service_response.dart';
// import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/shipping_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/shipping_widget.dart';
// import 'package:hand_bill/src/ui/screens/common/services_company_widget/customs_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_widget.dart';
// import 'package:hand_bill/src/ui/screens/services_package/shipping/shipping_widget.dart';
// import 'package:hand_bill/src/ui/screens/services_package/shipping/subShipping_Screen.dart';

// import '../../../../blocs/Services/Event.dart';
// import '../../../../blocs/Services/states.dart';
// import '../../../../blocs/category/category_bloc.dart';
import '../../../../blocs/Services/Event.dart';
import '../../../../blocs/category/category_event.dart';
import '../../../../common/constns.dart';
import '../../../../data/model/category/sub_sub.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../navigation_package/categories/component/category_empty_widget.dart';
import '../../navigation_package/categories/component/category_widget.dart';
// import '../../../../blocs/category/category_state.dart';
// import '../../../../data/model/local/route_argument.dart';
// import '../../navigation_package/categories/component/sub_category_widget.dart';
// import '../../navigation_package/categories/sub_category_screen.dart';

class ShippingMainScreen extends StatefulWidget {

  @override
  _ShippingMainScreenState createState() => _ShippingMainScreenState();
}

class _ShippingMainScreenState extends State<ShippingMainScreen>
    with SingleTickerProviderStateMixin {
  // // List<Company>? _items;
  // List<ServiceCategoryModel>? _categories;

  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  // ServiceBloc? _serviceBloc;
  // ScrollController? _scrollController;
  // static const offsetVisibleThreshold = 50.0;
  // bool loading = false;
  // // List<String> companies = [
  // //   translate("mtjm.shipping_clearance"),
  // //   translate("mtjm.contracting"),
  // //   translate("mtjm.tourism"),
  // //   translate("mtjm.petroleum"),
  // //   translate("mtjm.universities"),
  // //   translate("mtjm.hospitals"),
  // //   translate("mtjm.training_centers"),
  // //   translate("mtjm.consulting_offices"),
  // //   translate("mtjm.chartered_accountants"),
  // //   translate("mtjm.schools"),
  // //   translate("mtjm.not_found")
  // // ];
  // // String selectedCompanyKind = translate("mtjm.shipping_clearance");

  // // String selectSubNatureValue = "shipping_clearance";
  // // setSubNature(String val) {
  // //   setState(() {
  // //     if (val == translate("mtjm.contracting")) {
  // //       selectSubNatureValue = "contracting";
  // //     } else if (val == translate("mtjm.tourism")) {
  // //       selectSubNatureValue = "tourism";
  // //     } else if (val == translate("mtjm.petroleum")) {
  // //       selectSubNatureValue = "petroleum";
  // //     } else if (val == translate("mtjm.universities")) {
  // //       selectSubNatureValue = "universities";
  // //     } else if (val == translate("mtjm.hospitals")) {
  // //       selectSubNatureValue = "hospitals";
  // //     } else if (val == translate("mtjm.training_centers")) {
  // //       selectSubNatureValue = "training_centers";
  // //     } else if (val == translate("mtjm.consulting_offices")) {
  // //       selectSubNatureValue = "consulting_offices";
  // //     } else if (val == translate("mtjm.chartered_accountants")) {
  // //       selectSubNatureValue = "chartered_accountants";
  // //     } else if (val == translate("mtjm.schools")) {
  // //       selectSubNatureValue = "schools";
  // //     } else {
  // //       selectSubNatureValue = "shipping_clearance";
  // //     }
  // //   });
  // //   _otherCompanyBloc.shippingPage = 1;
  // //   _otherCompanyBloc
  // //     ..add(FetchShippingCompaniesEvent(subNature: selectSubNatureValue));
  // // }

  // @override
  // void initState() {
  //   _serviceBloc = BlocProvider.of<ServiceBloc>(context);
  //   if (_serviceBloc!.categories == null ||
  //       _serviceBloc!.categories!.length == 0)
  //     _serviceBloc!..add(FetchServiceEvent());
  //   // _otherCompanyBloc.shippingPage = 1;
  //   // _otherCompanyBloc
  //   //   ..add(FetchShippingCompaniesEvent(subNature: selectSubNatureValue));
  //   // _scrollController = ScrollController()..addListener(_onScroll);

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _scrollController!.dispose();
  //   super.dispose();
  // }

  // void _onScroll() {
  //   final max = _scrollController!.position.maxScrollExtent;
  //   final offset = _scrollController!.offset;
  //   if (offset + offsetVisibleThreshold >= max && !_serviceBloc!.isFetching) {
  //     setState(() {
  //       _serviceBloc!.isFetching = true;
  //     });
  //     // _serviceBloc
  //     //     .add(FetchShippingCompaniesEvent(subNature: selectSubNatureValue));
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xfff5f5f5),
  //     body: RefreshIndicator(
  //         onRefresh: () async {},
  //         child: BlocListener<ServiceBloc, ServiceState>(
  //           listener: (context, state) {
  //             if (state is CategoryErrorState) {
  //               _categories = [];
  //               SchedulerBinding.instance?.addPostFrameCallback((_) {
  //                 displaySnackBar(
  //                     title: state.errors, scaffoldKey: _scaffoldKey);
  //               });
  //             }
  //             if (state is CategoriesSuccessState) {
  //               if (_categories == null) {
  //                 print('done');
  //                 _categories = [];
  //               } else {}
  //             }

  //             // if (state is SubCategoriesSuccessState) {
  //             //   if (_subCategories == null) {
  //             //     _subCategories = [];
  //             //   }
  //             //   if (_selectedCategory != null &&
  //             //       state.items != null &&
  //             //       state.items!.length != 0) {
  //             //     if (_showRealLength == false) {
  //             //       SchedulerBinding.instance?.addPostFrameCallback((_) {
  //             //         setState(() {
  //             //           _showRealLength = true;
  //             //         });
  //             //       });
  //             //     }
  //             //     if (_subCategories!.length != 0 &&
  //             //         _subCategories!.first.id != state.items!.first.id) {
  //             //       _subCategories!.addAll(state.items!);
  //             //     } else if (_subCategories!.length == 0) {
  //             //       _subCategories!.addAll(state.items!);
  //             //     }
  //             //   }
  //             // }
  //             // if (state is OtherCompanyErrorState) {
  //             //   _items = [];
  //             //   SchedulerBinding.instance?.addPostFrameCallback((_) {
  //             //     displaySnackBar(
  //             //         title: state.error!, scaffoldKey: _scaffoldKey);
  //             //   });
  //             // }
  //             // if (state is ShippingSuccessState) {
  //             //   setState(() {
  //             //     if (_items == null) {
  //             //       _items = [];
  //             //     }
  //             //     // if(_items!.isNotEmpty){
  //             //     //   _items = [];
  //             //     //   _items!.forEach((element) {
  //             //     //     if(element.subNatureActivity==selectSubNatureValue){
  //             //     //       _items!.add(element);
  //             //     //     }
  //             //     //   });
  //             //     // }
  //             //     if (_items != null && _items!.isNotEmpty) {
  //             //       _items!.clear();
  //             //     }
  //             //     _items!.addAll(state.items!);
  //             //   });
  //             // }
  //           },
  //           child: ListView(children: [
  //             GridView.count(
  //                 padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
  //                 childAspectRatio: 1 / 0.7,
  //                 crossAxisCount: 2,
  //                 crossAxisSpacing: 2,
  //                 mainAxisSpacing: 2,
  //                 shrinkWrap: true,
  //                 primary: false,
  //                 children:
  //                     List.generate(_serviceBloc!.categories!.length, (index) {
  //                   return ShippingWidget(
  //                       model: _serviceBloc!.categories![index],
  //                       onTap: () => {});
  //                 })),
  //             SizedBox(height: 80),
  //           ]),
  //           // child: ListView(children: [
  //           //   GridView.count(
  //           //       padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
  //           //       childAspectRatio: 1 / 0.7,
  //           //       crossAxisCount: 2,
  //           //       crossAxisSpacing: 2,
  //           //       mainAxisSpacing: 2,
  //           //       shrinkWrap: true,
  //           //       primary: false,
  //           //       children:
  //           //           List.generate(_serviceBloc!.categories!.length, (index) {
  //           //         return ShippingWidget(
  //           //             model: _serviceBloc!.categories!.first,
  //           //             onTap: () => setState(() {
  //           //                   //  selectedCompanyKind = companies[index];
  //           //                 }));
  //           //       })),
  //           //   SizedBox(height: 80),
  //           // ]),
  //           // child: ListView(children: [
  //           //   GridView.count(
  //           //       padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
  //           //       childAspectRatio: 1 / 0.7,
  //           //       crossAxisCount: 2,
  //           //       crossAxisSpacing: 2,
  //           //       mainAxisSpacing: 2,
  //           //       shrinkWrap: true,
  //           //       primary: false,
  //           //       children: List.generate(companies.length, (index) {
  //           //         return CategoryWidget(
  //           //             model: CategoryModel(
  //           //               name: companies[index],
  //           //               selected: selectedCompanyKind == companies[index],
  //           //             ),
  //           //             onTap: () {
  //           //               setState(() {
  //           //                 selectedCompanyKind = companies[index];
  //           //               });
  //           //               Navigator.pushNamed(
  //           //                   context, SubShipingScreen.routeName,
  //           //                   arguments: RouteArgument());
  //           //             });
  //           //       })),
  //           //   SizedBox(height: 80),
  //           // ]),
  //           // child: CustomScrollView(
  //           //   physics: BouncingScrollPhysics(),
  //           //   controller: _scrollController,
  //           //   slivers: [
  //           //     SliverToBoxAdapter(
  //           //         child: Column(
  //           //             crossAxisAlignment: CrossAxisAlignment.start,
  //           //             children: [
  //           //           Container(
  //           //               padding: EdgeInsets.only(bottom: 40),
  //           //               decoration: BoxDecoration(
  //           //                   color: Color(0xffffffff),
  //           //                   border: Border.symmetric(
  //           //                       vertical:
  //           //                           BorderSide(color: Color(0xffeeeeee)))),
  //           //               child: companies.isEmpty
  //           //                   ? ListView.builder(
  //           //                       shrinkWrap: true,
  //           //                       physics: BouncingScrollPhysics(),
  //           //                       itemCount: 6,
  //           //                       itemBuilder: (context, index) {
  //           //                         return CategoryEmptyWidget();
  //           //                       })
  //           //                   : SizedBox(
  //           //                       height: 70,
  //           //                       child: ListView.builder(
  //           //                           scrollDirection: Axis.horizontal,
  //           //                           shrinkWrap: true,
  //           //                           physics: BouncingScrollPhysics(),
  //           //                           itemCount: companies.length,
  //           //                           itemBuilder: (context, index) {
  //           //                             return CategoryWidget(
  //           //                                 model: CategoryModel(
  //           //                                   name: companies[index],
  //           //                                   selected: selectedCompanyKind ==
  //           //                                       companies[index],
  //           //                                 ),
  //           //                                 onTap: () {
  //           //                                   setState(() {
  //           //                                     selectedCompanyKind =
  //           //                                         companies[index];
  //           //                                   });
  //           //                                   setSubNature(companies[index]);
  //           //                                 });
  //           //                             return CategoryEmptyWidget();
  //           //                           }),
  //           //                     )),
  //           //           _items != null && _items!.isNotEmpty
  //           //               ? Container(
  //           //                   child: Column(children: [
  //           //                     _items == null || _items!.length == 0
  //           //                         ? CenterWidgetListSliver(
  //           //                             label: translate("mtjm.not_found"))
  //           //                         : ListView.separated(
  //           //                             physics: BouncingScrollPhysics(),
  //           //                             // padding: EdgeInsets.symmetric(vertical: 16),
  //           //                             primary: false,
  //           //                             shrinkWrap: true,
  //           //                             itemCount: _items!.length,
  //           //                             scrollDirection: Axis.vertical,
  //           //                             itemBuilder: (context, index) {
  //           //                               return CustomsWidget(
  //           //                                 model: _items![index],
  //           //                               );
  //           //                             },
  //           //                             separatorBuilder:
  //           //                                 (BuildContext context,
  //           //                                         int index) =>
  //           //                                     Container(
  //           //                                         height: 10,
  //           //                                         color:
  //           //                                             Color(0xffeeeeee))),
  //           //                   ]),
  //           //                 )
  //           //               : Center(
  //           //                   child: CircularProgressIndicator(),
  //           //                 ),
  //           //         ])),
  //           //   ],
  //           // )
  //         )),
  //   );
  // }
  List<GetDataCategory>? _categories;

  List<SubCategoryModel>? _subCategories;

  ScrollController? _scrollController;
  double offsetVisibleThreshold = 100;

  GetDataCategory? _selectedCategory;
  ServiceBlocData? _serviceBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  get categories => null;
  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBlocData>(context);
    if (_serviceBloc!.categories == null ||
        _serviceBloc!.categories!.length == 0)
    _serviceBloc!..add(FetchServiceEvent());
    // _serviceBloc!..add(ServiceBannerCompanyEvent());


    // if (_serviceBloc!.subCategories == null ||
    //     _serviceBloc!.subCategories!.length == 0)
    //   _serviceBloc!
    //     ..add(FetchSubCategoriesEvent(
    //         categoryId: _categoryBloc!.categories!.first.id.toString()));
    // if (_serviceBloc!.subCategories != null &&
    //     _serviceBloc!.categories!.length != 0) {
    //   _subCategories = _serviceBloc!.subCategories;
    // }
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   if (_categories != null) {
    //     setState(() {
    //       _categories![0].selected = true;
    //       _selectedCategory = _categories![0];
    //     });
    //   }
    // });
    // _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  bool _showRealLength = false;
  int? _showRealSubLengthIndex;
  // void _onScroll() {
  //   final max = _scrollController!.position.maxScrollExtent;
  //   final offset = _scrollController!.offset;
  //   if (offset + offsetVisibleThreshold >= max && !_categoryBloc!.isFetching) {
  //     _categoryBloc!.isFetching = true;
  //     if (_selectedCategory == null)
  //       _selectedCategory = _categoryBloc!.categories!.first;
  //     if (_showRealLength == false)
  //       setState(() {
  //         _showRealLength = true;
  //       });
  //     Timer(Duration(seconds: 6), () {
  //       _categoryBloc!.add(FetchSubCategoriesEvent(
  //           categoryId: _selectedCategory!.id.toString()));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: BlocListener<ServiceBlocData, ServiceState>(
            listener: (context, state) {

              if (state is CategoryErrorState) {
                _categories = [];
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  displaySnackBar(
                      title: state.errors, scaffoldKey: _scaffoldKey);
                });
              }
              if (state is CategoriesSuccessState) {
                if (_categories == null) {
                  _categories = [];
                  ShippingMainScreen();
                  if (_serviceBloc!.categories!.length == 2) {
                    print('done');
                  }

                  // print(_serviceBloc!.categories!.first.data!.first.name);
                } else {}
              }
              // if (state is SubCategoriesSuccessState) {
              //   if (_subCategories == null) {
              //     _subCategories = [];
              //   }
              //   if (_selectedCategory != null &&
              //       state.items != null &&
              //       state.items!.length != 0) {
              //     if (_showRealLength == false) {
              //       SchedulerBinding.instance?.addPostFrameCallback((_) {
              //         setState(() {
              //           _showRealLength = true;
              //         });
              //       });
              //     }
              //     if (_subCategories!.length != 0 &&
              //         _subCategories!.first.id != state.items!.first.id) {
              //       _subCategories!.addAll(state.items!);
              //     } else if (_subCategories!.length == 0) {
              //       _subCategories!.addAll(state.items!);
              //     }
              //   }
              // }
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
            //       children:
            //           List.generate(_serviceBloc!.categories!.length, (index) {
            //         return CategoryWidget(
            //             model: _serviceBloc!.categories![index],
            //             onTap: () =>
            //                 onCategoryTap(_serviceBloc!.categories![index]));
            //       })),
            //   SizedBox(height: 80),
            // ]),
            // child: ListView(children: [
            //   GridView.count(
            //       padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            //       childAspectRatio: 1 / 0.7,
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 2,
            //       mainAxisSpacing: 2,
            //       shrinkWrap: true,
            //       primary: false,
            //       children: List.generate(2, (index) {
            //         return ShippingWidget(
            //             model: _serviceBloc!.categories![index], onTap: () => {}
            //             // onCategoryTap(_categoryBloc!.categories![index])
            //             );
            //       })),
            //   SizedBox(height: 80),
            // ]),
            child: ListView(children: [
              GridView.count(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
                  childAspectRatio: 1 / 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  shrinkWrap: true,
                  primary: false,
                  children:
                      List.generate(_serviceBloc!.categories!.length, (index) {
                    return ShippingWidget(
                        model: _serviceBloc!.categories![index],
                        onTap: () =>
                            onCategoryTap(_serviceBloc!.categories![index]));
                  })),
              SizedBox(height: 80),
            ]),
            // child: ConditionalBuilder(
            //   condition: _categories != null,
            //   builder: (context) => builditem(),
            //   fallback: (context) => Container(
            //     color: Colors.white,
            //     child: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),
            // )
            // ListView.separated(
            //   padding: const EdgeInsets.all(8),
            //   itemCount: _serviceBloc!.categories!.first.data!.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       height: 50,
            //       color: Colors.amber,
            //       child: Center(child: Text('sss')),
            //     );
            //   },
            //   separatorBuilder: (BuildContext context, int index) =>
            //       const Divider(),
            // ),
            // child: ListView(children: [
            //   GridView.count(
            //       padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            //       childAspectRatio: 1 / 0.7,
            //       crossAxisCount: 2,
            //       crossAxisSpacing: 2,
            //       mainAxisSpacing: 2,
            //       shrinkWrap: true,
            //       primary: false,
            //       children: List.generate(2, (index) {
            //         return ShippingWidget(
            //             model: _serviceBloc!.categories![index], onTap: () => {}
            //             // onCategoryTap(_categoryBloc!.categories![index])
            //             );
            //       })),
            //   SizedBox(height: 80),
            // ]),
            // child: CustomScrollView(
            //     physics: BouncingScrollPhysics(),
            //     controller: _scrollController,
            //     slivers: [
            //       SliverToBoxAdapter(
            //         child: GridView.builder(
            //           // scrollDirection: Axis.vertical,

            //           shrinkWrap: true,
            //           itemBuilder: (context, index) {
            //             if (_serviceBloc!.categories!.isNotEmpty) {
            //               return ShippingWidget(
            //                   model: _serviceBloc!.categories![index],
            //                   onTap: () => onCategoryTap(
            //                       _serviceBloc!.categories![index]));
            //             }
            //             return CategoryEmptyWidget();
            //           },
            //           itemCount: _serviceBloc!.categories!.length,
            //           gridDelegate:
            //               const SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2,
            //           ),
            //           // separatorBuilder:
            //           //     (BuildContext context, int index) =>
            //           //         SizedBox(
            //           //   width: 10,
            //           // ),
            //         ),
            //       )
            //     ])
          ),
        ));

    // Scaffold(
    //     backgroundColor: Color(0xfff5f5f5),
    //     body: RefreshIndicator(
    //       onRefresh: () async {},
    //       child: BlocBuilder<CategoryBloc, CategoryState>(
    //           builder: (context, state) {
    //         if (state is CategoryErrorState) {
    //           _categories = [];
    //           SchedulerBinding.instance?.addPostFrameCallback((_) {
    //             displaySnackBar(title: state.errors, scaffoldKey: _scaffoldKey);
    //           });
    //         }
    //         if (state is CategoriesSuccessState) {
    //           if (_categories == null) {
    //             _categories = [];
    //           } else {}
    //         }
    //         if (state is SubCategoriesSuccessState) {
    //           if (_subCategories == null) {
    //             _subCategories = [];
    //           }
    //           if (_selectedCategory != null &&
    //               state.items != null &&
    //               state.items!.length != 0) {
    //             if (_showRealLength == false) {
    //               SchedulerBinding.instance?.addPostFrameCallback((_) {
    //                 setState(() {
    //                   _showRealLength = true;
    //                 });
    //               });
    //             }
    //             if (_subCategories!.length != 0 &&
    //                 _subCategories!.first.id != state.items!.first.id) {
    //               _subCategories!.addAll(state.items!);
    //             } else if (_subCategories!.length == 0) {
    //               _subCategories!.addAll(state.items!);
    //             }
    //           }
    //         }

    //         return CustomScrollView(
    //             physics: BouncingScrollPhysics(),
    //             controller: _scrollController,
    //             slivers: [
    //               SliverToBoxAdapter(
    //                 child: GridView.builder(
    //                   // scrollDirection: Axis.vertical,

    //                   shrinkWrap: true,
    //                   itemBuilder: (context, index) {
    //                     if (_categoryBloc!.categories!.isNotEmpty) {
    //                       return CategoryWidget(
    //                           model: _categoryBloc!.categories![index],
    //                           onTap: () => onCategoryTap(
    //                               _categoryBloc!.categories![index]));
    //                     }
    //                     return CategoryEmptyWidget();
    //                   },
    //                   itemCount: _categoryBloc!.categories!.length,
    //                   gridDelegate:
    //                       const SliverGridDelegateWithFixedCrossAxisCount(
    //                     crossAxisCount: 2,
    //                   ),
    //                   // separatorBuilder:
    //                   //     (BuildContext context, int index) =>
    //                   //         SizedBox(
    //                   //   width: 10,
    //                   // ),
    //                 ),
    //               )
    //             ]);
    //       }),
    //     ));
  }

  onCategoryTap(
      GetDataCategory serviceCategoryModel,) {
    if (_serviceBloc!.categories!.first.selected == false) {
      _serviceBloc!.categories!.first.selected = true;
    }
    setState(() {
    if (_selectedCategory != null) {
       _selectedCategory!.selected = false;
    }
    if (_subCategories != null) _subCategories!.clear();
    setState(() {
      _showRealLength = false;
      _showRealSubLengthIndex = -100;
       serviceCategoryModel.selected = !serviceCategoryModel.selected!;
      _selectedCategory = serviceCategoryModel;
        _serviceBloc!.subCatPage = 1;

      Navigator.pushNamed(context, ShippingScreen.routeName,
          arguments: RouteArgument(
              param: serviceCategoryModel.name,
              id: serviceCategoryModel.id.toString()));
    });
    });
  }

  Widget builditem() => ListView(children: [
        GridView.count(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
            childAspectRatio: 1 / 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            primary: false,
            children: List.generate(_serviceBloc!.categories!.length, (index) {
              return ShippingWidget(
                  model: _serviceBloc!.categories![index],
                  onTap: () => onCategoryTap(_serviceBloc!.categories![index]));
            })),
        SizedBox(height: 80),
      ]);
}
