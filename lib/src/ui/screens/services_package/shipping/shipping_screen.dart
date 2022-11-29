import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_bloc.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_event.dart';
import 'package:hand_bill/src/blocs/other_company/other_company_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/category/sub.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/services/companies.dart';
import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/common/services_company_widget/customs_widget.dart';
import 'package:hand_bill/src/ui/screens/services_package/customs/customs_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/ShippingBloc%20/cubit.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/shippinhWidget.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/states.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/widget/service_banner_widget.dart';

import '../../../../common/api_data.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../../../data/response/banner/banner_service_response.dart';
import '../../navigation_package/categories/sub_sub_categories.dart';
import '../../navigation_package/home/componenet/slider_empty_widget.dart';
import 'ShippingBloc /ShippingEvent.dart';
import 'ShippingBloc /ShippingState.dart';

// class ShippingScreen extends StatefulWidget {
//   static const routeName = "/ShippingScreen";
//   late final RouteArgument? routeArgument;

//   ShippingScreen({required this.routeArgument});

//   @override
//   _ShippingScreenState createState() => _ShippingScreenState();
// }

// class _ShippingScreenState extends State<ShippingScreen>
//     with SingleTickerProviderStateMixin {
//   List<Company>? _items;

//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   late OtherCompanyBloc _otherCompanyBloc;
//   ScrollController? _scrollController;
//   static const offsetVisibleThreshold = 50.0;
//   bool loading = false;
//   TabController? _tabController;

//   @override
//   void initState() {
//     _otherCompanyBloc = BlocProvider.of<OtherCompanyBloc>(context);
//     // _otherCompanyBloc.shippingPage = 1;
//     _otherCompanyBloc
//       .add(FetchShippingCompaniesEvent(
//           subNature: widget.routeArgument!.param.toString()));
//     _scrollController = ScrollController().addListener(_onScroll);
//     _tabController = new TabController(vsync: this, length: 2);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController!.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final max = _scrollController!.position.maxScrollExtent;
//     final offset = _scrollController!.offset;
//     if (offset + offsetVisibleThreshold >= max &&
//         !_otherCompanyBloc.isFetching) {
//       setState(() {
//         _otherCompanyBloc.isFetching = true;
//       });
//       _otherCompanyBloc.add(FetchShippingCompaniesEvent(subNature: ''));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfff5f5f5),
//       appBar: RegularAppBar(label: widget.routeArgument!.param.toString()),
//       // appBar: AppBar(
//       //   // elevation: 0,
//       //   // toolbarHeight: 5.h,
//       //   backgroundColor: Colors.white,
//       //   //  iconTheme: IconThemeData(color: mainColor),
//       //   iconTheme: IconThemeData(color: Colors.black),

//       //   // bottom: TabBar(
//       //   //   labelColor: mainColor,
//       //   //   labelStyle: TextStyle(color: Colors.white),
//       //   //   unselectedLabelColor: Colors.black54,
//       //   //   controller: _tabController,
//       //   //   tabs: [
//       //   //     Tab(
//       //   //       child: Text(translate("categories.shipping")),
//       //   //     ),
//       //   //     Tab(
//       //   //       child: Text(translate("categories.customs_broker")),
//       //   //     ),
//       //   //   ],
//       //   // ),
//       // ),
//       body:
//           //  TabBarView(
//           // controller: _tabController,
//           // children: [
//           Scaffold(
//         // appBar: RegularAppBar(label: "Shipping"),
//         body: RefreshIndicator(
//           onRefresh: () async {
//             // if (_items != null) {
//             //   _items!.clear();
//             //   _items = null;
//             // }
//             // _otherCompanyBloc.shippingPage = 1;
//             // // _otherCompanyBloc.add(FetchShippingCompaniesEvent(
//             // //     subNature: widget.routeArgument!.param.toString()));
//           },
//           child: BlocListener<OtherCompanyBloc, OtherCompanyState>(
//               listener: (context, state) {
//                 if (state is OtherCompanyErrorState) {
//                   _items = [];
//                   SchedulerBinding.instance?.addPostFrameCallback((_) {
//                     displaySnackBar(
//                         title: state.error!, scaffoldKey: _scaffoldKey);
//                   });
//                 }
//                 if (state is ShippingSuccessState) {
//                   setState(() {
//                     if (_items == null) {
//                       _items = [];
//                     }
//                     _items!.addAll(state.items!);
//                   });
//                 }
//               },
//               // child: Container(),
//               child: CustomScrollView(
//                   physics: BouncingScrollPhysics(),
//                   controller: _scrollController,
//                   slivers: [
//                     _items == null
//                         ? LoadingSliver()
//                         : _items!.length == 0
//                             ? CenterWidgetListSliver(
//                                 label: translate("mtjm.not_found"))
//                             : SliverToBoxAdapter(
//                                 child: ListView.separated(
//                                     physics: BouncingScrollPhysics(),
//                                     // padding: EdgeInsets.symmetric(vertical: 16),
//                                     primary: false,
//                                     shrinkWrap: true,
//                                     itemCount: _items!.length,
//                                     scrollDirection: Axis.vertical,
//                                     itemBuilder: (context, index) {
//                                       return CustomsWidget(
//                                           model: _items![index]);
//                                     },
//                                     separatorBuilder:
//                                         (BuildContext context, int index) =>
//                                             Container(
//                                                 height: 10,
//                                                 color: Color(0xffeeeeee)))),
//                     SliverToBoxAdapter(child: SizedBox(height: 100)),
//                     SliverToBoxAdapter(
//                         child: Container(
//                             child: loading == true
//                                 ? Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 40),
//                                     child: Align(
//                                         alignment: Alignment.bottomCenter,
//                                         child: CircularProgressIndicator(
//                                             strokeWidth: 2)))
//                                 : SizedBox()))
//                   ])),
//         ),
//       ),
//       // CustomsScreen(),
//       // ],
//       // ),
//     );
//   }
// }

// ///////////////////////

// class ShippingScreen extends StatefulWidget {
//    static const routeName = "/ShippingScreen";
//   late final RouteArgument? routeArgument;

//   ShippingScreen({required this.routeArgument});
//   _ShippingScreenState createState() => _ShippingScreenState();
// }

// class _ShippingScreenState extends State<ShippingScreen> {
//   List<CategoryModel>? _categories;

//   List<SubCategoryModel>? _ShippingScreen;

//   ScrollController? _scrollController;
//   double offsetVisibleThreshold = 100;

//   CategoryModel? _selectedCategory;
//   CategoryBloc? _categoryBloc;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     _categoryBloc = BlocProvider.of<CategoryBloc>(context);
//     if (_categoryBloc!.categories == null ||
//         _categoryBloc!.categories!.length == 0)
//       _categoryBloc!.add(FetchCategoriesEvent());
//     if (_categoryBloc!.ShippingScreen == null ||
//         _categoryBloc!.ShippingScreen!.length == 0)
//       _categoryBloc!
//         .add(FetchShippingScreenEvent(
//             categoryId: widget.routeArgument!.id.toString()));
//     if (_categoryBloc!.ShippingScreen != null &&
//         _categoryBloc!.categories!.length != 0) {
//       _ShippingScreen = _categoryBloc!.ShippingScreen;
//     }
//     SchedulerBinding.instance!.addPostFrameCallback((_) {
//       if (_categories != null) {
//         setState(() {
//           _categories![0].selected = true;
//           _selectedCategory = _categories![0];
//         });
//       }
//     });
//     _scrollController = ScrollController().addListener(_onScroll);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController!.dispose();
//     super.dispose();
//   }

//   bool _showRealLength = false;
//   int? _showRealSubLengthIndex;
//   void _onScroll() {
//     final max = _scrollController!.position.maxScrollExtent;
//     final offset = _scrollController!.offset;
//     if (offset + offsetVisibleThreshold >= max && !_categoryBloc!.isFetching) {
//       _categoryBloc!.isFetching = true;
//       if (_selectedCategory == null)
//         _selectedCategory = _categoryBloc!.categories!.first;
//       if (_showRealLength == false)
//         setState(() {
//           _showRealLength = true;
//         });
//       Timer(Duration(seconds: 6), () {
//         _categoryBloc!.add(FetchShippingScreenEvent(
//             categoryId: _selectedCategory!.id.toString()));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: RegularAppBar(label: widget.routeArgument!.id.toString()),
//         key: _scaffoldKey,
//         backgroundColor: Color(0xfff5f5f5),
//         body: RefreshIndicator(onRefresh: () async {
//           if (_categories != null) {
//             // _categories!.clear();
//             // _categories = null;
//           }

//           // _categoryBloc.allPage = 1;
//           // _categoryBloc.add(FetchCategoriesEvent());
//         }, child:
//             BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
//           if (state is CategoryErrorState) {
//             _categories = [];
//             SchedulerBinding.instance?.addPostFrameCallback((_) {
//               displaySnackBar(title: state.errors, scaffoldKey: _scaffoldKey);
//             });
//           }
//           if (state is CategoriesSuccessState) {
//             if (_categories == null) {
//               _categories = [];
//             } else {}
//           }
//           if (state is ShippingScreenSuccessState) {
//             if (_ShippingScreen == null) {
//               _ShippingScreen = [];
//             }
//             if (_selectedCategory != null &&
//                 state.items != null &&
//                 state.items!.length != 0) {
//               if (_showRealLength == false) {
//                 SchedulerBinding.instance?.addPostFrameCallback((_) {
//                   setState(() {
//                     _showRealLength = true;
//                   });
//                 });
//               }
//               if (_ShippingScreen!.length != 0 &&
//                   _ShippingScreen!.first.id != state.items!.first.id) {
//                 _ShippingScreen!.addAll(state.items!);
//               } else if (_ShippingScreen!.length == 0) {
//                 _ShippingScreen!.addAll(state.items!);
//               }
//             }
//           }

//           return CustomScrollView(
//               controller: _scrollController,
//               physics: BouncingScrollPhysics(),
//               slivers: [
//                 SliverToBoxAdapter(
//                     child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                       // Expanded(
//                       //     flex: 3,
//                       //     child: Container(
//                       //         padding: EdgeInsets.only(bottom: 40),
//                       //         decoration: BoxDecoration(
//                       //             color: Color(0xffffffff),
//                       //             border: Border.symmetric(
//                       //                 vertical: BorderSide(
//                       //                     color: Color(0xffeeeeee)))),
//                       //         child: _categoryBloc!.categories == null
//                       //             ? ListView.builder(
//                       //                 shrinkWrap: true,
//                       //                 physics: BouncingScrollPhysics(),
//                       //                 itemCount: 6,
//                       //                 itemBuilder: (context, index) {
//                       //                   return CategoryEmptyWidget();
//                       //                 })
//                       //             : ListView.builder(
//                       //                 shrinkWrap: true,
//                       //                 physics: BouncingScrollPhysics(),
//                       //                 itemCount:
//                       //                     _categoryBloc!.categories!.length,
//                       //                 itemBuilder: (context, index) {
//                       //                   if (_categoryBloc!
//                       //                       .categories!.isNotEmpty) {
//                       //                     return CategoryWidget(
//                       //                         model: _categoryBloc!
//                       //                             .categories![index],
//                       //                         onTap: () => onCategoryTap(
//                       //                             _categoryBloc!
//                       //                                 .categories![index]));
//                       //                   }
//                       //                   return CategoryEmptyWidget();
//                       //                 }))),
//                       // Expanded(
//                       //     flex: 3,
//                       //     child: Container(
//                       //         padding: EdgeInsets.only(bottom: 40),
//                       //         decoration: BoxDecoration(
//                       //             color: Color(0xffffffff),
//                       //             border: Border.symmetric(
//                       //                 vertical: BorderSide(
//                       //                     color: Color(0xffeeeeee)))),
//                       //         child: _categoryBloc!.categories == null
//                       //             ? ListView.builder(
//                       //                 shrinkWrap: true,
//                       //                 physics: BouncingScrollPhysics(),
//                       //                 itemCount: 6,
//                       //                 itemBuilder: (context, index) {
//                       //                   return CategoryEmptyWidget();
//                       //                 })
//                       //             : ListView.builder(
//                       //                 shrinkWrap: true,
//                       //                 physics: BouncingScrollPhysics(),
//                       //                 itemCount:
//                       //                     _categoryBloc!.categories!.length,
//                       //                 itemBuilder: (context, index) {
//                       //                   if (_categoryBloc!
//                       //                       .categories!.isNotEmpty) {
//                       //                     return CategoryWidget(
//                       //                         model: _categoryBloc!
//                       //                             .categories![index],
//                       //                         onTap: () => onCategoryTap(
//                       //                             _categoryBloc!
//                       //                                 .categories![index]));
//                       //                   }
//                       //                   return CategoryEmptyWidget();
//                       //                 }))),
//                       Expanded(
//                           flex: 7,
//                           child: Container(
//                             padding: EdgeInsets.only(bottom: 30),
//                             margin: EdgeInsets.only(left: 6, right: 8),
//                             child: Column(children: [
//                               _ShippingScreen == null ||
//                                       _ShippingScreen!.length == 0
//                                   ? ListView.separated(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 12),
//                                       primary: false,
//                                       shrinkWrap: true,
//                                       itemCount: 4,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         return SubCategoryEmptyWidget();
//                                       },
//                                       separatorBuilder:
//                                           (BuildContext context, int index) =>
//                                               SizedBox(height: 8))
//                                   : ListView.separated(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 12),
//                                       primary: false,
//                                       shrinkWrap: true,
//                                       itemCount: _showRealLength == true
//                                           ? _ShippingScreen!.length
//                                           : (_ShippingScreen!.first
//                                                       .subSubCategory!.length >
//                                                   6
//                                               ? 1
//                                               : 2),
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         return Stack(
//                                           alignment: Alignment.bottomRight,
//                                           children: [
//                                             SubCategoryWidget(
//                                                 realLength: _showRealSubLengthIndex !=
//                                                             null &&
//                                                         _showRealSubLengthIndex ==
//                                                             index
//                                                     ? _ShippingScreen![index]
//                                                         .subSubCategory!
//                                                         .length
//                                                     : (_ShippingScreen![index]
//                                                                 .subSubCategory!
//                                                                 .length >
//                                                             10
//                                                         ? 10
//                                                         : (_ShippingScreen![
//                                                                         index]
//                                                                     .subSubCategory!
//                                                                     .length >=
//                                                                 5
//                                                             ? 5
//                                                             : 1)),
//                                                 model: _ShippingScreen![index]),
//                                             if (_ShippingScreen![index]
//                                                         .subSubCategory!
//                                                         .length !=
//                                                     0 &&
//                                                 _ShippingScreen![index]
//                                                         .subSubCategory!
//                                                         .length >
//                                                     3)
//                                               Align(
//                                                 alignment:
//                                                     Alignment.bottomRight,
//                                                 child: GestureDetector(
//                                                     onTap: () async {
//                                                       setState(() {
//                                                         _showRealSubLengthIndex =
//                                                             index;
//                                                       });
//                                                     },
//                                                     child: Container(
//                                                       color: Colors.white,
//                                                       margin:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal: 15.w,
//                                                               vertical: 20.h),
//                                                       child: RichText(
//                                                         softWrap: true,
//                                                         maxLines: 2,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         text:
//                                                             TextSpan(children: [
//                                                           if (_showRealSubLengthIndex !=
//                                                               index)
//                                                             TextSpan(
//                                                               text: translate(
//                                                                   "button.show_more"),
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .blue
//                                                                     .withOpacity(
//                                                                         0.5),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 decoration:
//                                                                     TextDecoration
//                                                                         .underline,
//                                                                 fontSize: 25.sp,
//                                                               ),
//                                                             ),
//                                                           TextSpan(text: " "),
//                                                         ]),
//                                                       ),
//                                                     )),
//                                               ),
//                                           ],
//                                         );
//                                       },
//                                       separatorBuilder:
//                                           (BuildContext context, int index) =>
//                                               SizedBox(height: 8)),
//                             ]),
//                           )),
//                     ])),
//               ]);
//         })));
//   }

//   onCategoryTap(CategoryModel categoryModel) {
//     if (_categoryBloc!.categories!.first.selected == true) {
//       _categoryBloc!.categories!.first.selected = false;
//     }
//     // setState(() {
//     if (_selectedCategory != null) {
//       _selectedCategory!.selected = false;
//     }
//     if (_ShippingScreen != null) _ShippingScreen!.clear();
//     setState(() {
//       _showRealLength = false;
//       _showRealSubLengthIndex = -100;
//       _categoryBloc!.isPaginationFinished = false;
//       categoryModel.selected = !categoryModel.selected!;
//       _selectedCategory = categoryModel;
//       _categoryBloc!.subCatPage = 1;
//     });
//     _categoryBloc!
//         .add(FetchShippingScreenEvent(categoryId: categoryModel.id.toString()));
//     // });
//   }
// }
class ShippingScreen extends StatefulWidget {
  static const routeName = "/ShippingScreen";
  late final RouteArgument? routeArgument;

  ShippingScreen({required this.routeArgument});
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  List<BannerServiceModel>? banner;
SubCategoryModel? companyModel;

  ShippingBloc? shippingBloc;
  int _sliderPosition = 0;
  // BlocProvider(
  //       create: ((context) => ShippingBloc()
  //         ..getCategory(subNature: widget.routeArgument!.id.toString())),
  //
  //       child:
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget!.routeArgument!.id);
    shippingBloc = BlocProvider.of<ShippingBloc>(context);
    shippingBloc!.add(ShippingSliderServiceEvent());
    shippingBloc!.add(ShippingCategoryServiceEvent(widget!.routeArgument!.id));
  }

  @override
  Widget build(BuildContext context) {
    var model;
    return BlocConsumer<ShippingBloc, ShippingState>(
        listener: (context, state) {
          if(state is BannerCompanySuccessState){
            // print(banner![0].id);
            print('البت امنيه');
            banner = state.banner!;

          }
          if(state is GebServiceCatSuccessStates){
            print('ssssssssa');
            companyModel = state.category;
          }
        },
        builder: (context, state) {
          // model = ShippingBloc.get(context).companyModel;
          return Scaffold(
            backgroundColor: Color(0xfff5f5f5),
            appBar:
            RegularAppBar(label: widget.routeArgument!.param.toString()),
            body: SizedBox(
              height: 700,
              child: SingleChildScrollView(

                child: Column(
                children :[
                 Column(
                    children: [
                      banner == null
                          ? CircularProgressIndicator()
                          :
                      SizedBox(
                        height: 200,
                        child: CarouselSlider.builder(
                          itemCount: banner!.length,
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
          if (banner!.isNotEmpty) {
          return BannerWidget(
          model: banner![index]);
          }
          return SliderEmptyWidget();
        },
                          options: CarouselOptions(
                              viewportFraction: 1,
                              initialPage: 0,
                              // enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                              autoPlayInterval: Duration(milliseconds: 4000),
                              autoPlayCurve: Curves.easeOutSine,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _sliderPosition = index;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  child: ConditionalBuilder(
                    condition: companyModel != null,
                    builder: (context) =>
                    companyModel == null
                    ? Container()

                       : item(companyModel!),
                    fallback: (context) =>
                        Container(color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  ),
                ),
              ]),
            ),
          ));
        },

    );
  }

  // Widget item(SubCategoryModel model) =>
  //     InkWell(
  //       onTap: (){
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //             child: ListView.separated(
  //                 physics: BouncingScrollPhysics(),
  //                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
  //                 primary: false,
  //                 shrinkWrap: true,
  //                 itemCount: model.data!.length,
  //                 scrollDirection: Axis.vertical,
  //                 itemBuilder: (context, index) =>
  //                     ShapWidget(
  //                       model: model!.data![index],
  //                     ),
  //                 separatorBuilder: (BuildContext context, int index) =>
  //                     Container(height: 10, color: Color(0xffeeeeee))
  //               //  ShapWidget(
  //               //   model: model.data.firs[index],
  //               // );
  //
  //               // separatorBuilder: (BuildContext context, int index) =>
  //               //     Container(height: 10, color: Color(0xffeeeeee))
  //             )),
  //       ),
  //     );

  Widget item(SubCategoryModel model) => ListView(children: [
    GridView.count(
      // padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
        childAspectRatio: 1 / 0.7,
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        shrinkWrap: true,
        primary: false,
        children: List.generate(model.data!.length,(index) {
          return InkWell(
            onTap: () {
              print('fdfdfdfdfdfdf');
              print('${model.data![index].id}');
              Navigator.pushNamed(context, SubSubCatScreen.routeName,
                  arguments: RouteArgument(
                    id: model.data![index].id.toString(),
                    param: model.data![index].name.toString(),
                  ));
            },
            child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          model.data![index].icon == null
                              ? Container(
                            child: Image.asset(
                              "assets/images/Hbill.jpeg",
                              height: 40,
                              // width: 20,
                            ),
                          )
                              : Image.network(
                            '${APIData.domainLink}${model.data![index].icon!.thump}',
                            height: 30,
                          ),
                          Text(model.data![index].name.toString(),
                              style: model.data![index].id.toString() ==
                                  model.data!.first.id.toString()
                                  ? TextStyle(
                                  color: mainColorLite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)
                                  : TextStyle(
                                color: textDarkColor,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis)
                        ]))),
          );
          // InkWell(
          //   child: Card(
          //       elevation: 5,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8)),
          //       child: Padding(
          //           padding:
          //               EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          //           child: Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceAround,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(model.data![index].name!,

          //                     style: model.selected == true
          //                     ? TextStyle(
          //                         color: mainColorLite,
          //                         fontWeight: FontWeight.w500,
          //                         fontSize: 12)
          //                     :
          //                      TextStyle(
          //                         color: textDarkColor,
          //                         fontWeight: FontWeight.w500,
          //                       ),
          //                     maxLines: 3,
          //                     textAlign: TextAlign.center,
          //                     overflow: TextOverflow.ellipsis)
          //               ]))),
          // );
        })),
    SizedBox(height: 80),
  ]);

}