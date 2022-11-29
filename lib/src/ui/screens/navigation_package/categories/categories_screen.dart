// import 'dart:async';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:hand_bill/src/blocs/category/category_bloc.dart';
// import 'package:hand_bill/src/blocs/category/category_event.dart';
// import 'package:hand_bill/src/blocs/category/category_state.dart';
// import 'package:hand_bill/src/data/model/category/category.dart';
// import 'package:hand_bill/src/data/model/category/sub_category.dart';
// import 'package:hand_bill/src/ui/component/widgets.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_empty_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_widget.dart';

// class CategoriesScreen extends StatefulWidget {
//   @override
//   _CategoriesScreenState createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   List<CategoryModel>? _categories;

//   List<SubCategoryModel>? _subCategories;

//   ScrollController? _scrollController;
//   double offsetVisibleThreshold = 100;

//   CategoryModel? _selectedCategory;
//   CategoryBloc? _categoryBloc;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     _categoryBloc = BlocProvider.of<CategoryBloc>(context);
//     if (_categoryBloc.categories == null ||
//         _categoryBloc.categories!.length == 0)
//       _categoryBloc.add(FetchCategoriesEvent());
//     if (_categoryBloc.subCategories == null ||
//         _categoryBloc.subCategories!.length == 0)
//       _categoryBloc
//         .add(FetchSubCategoriesEvent(
//             categoryId: _categoryBloc.categories!.first.id.toString()));
//     if (_categoryBloc.subCategories != null &&
//         _categoryBloc.categories!.length != 0) {
//       _subCategories = _categoryBloc.subCategories;
//     }
//     // SchedulerBinding.instance!.addPostFrameCallback((_) {
//     //   if (_categories != null) {
//     //     setState(() {
//     //       _categories![0].selected = true;
//     //       _selectedCategory = _categories![0];
//     //     });
//     //   }
//     // });
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
//     if (offset + offsetVisibleThreshold >= max && !_categoryBloc.isFetching) {
//       _categoryBloc.isFetching = true;
//       if (_selectedCategory == null)
//         _selectedCategory = _categoryBloc.categories!.first;
//       if (_showRealLength == false)
//         setState(() {
//           _showRealLength = true;
//         });
//       Timer(Duration(seconds: 6), () {
//         _categoryBloc.add(FetchSubCategoriesEvent(
//             categoryId: _selectedCategory!.id.toString()));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//           if (state is SubCategoriesSuccessState) {
//             if (_subCategories == null) {
//               _subCategories = [];
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
//               if (_subCategories!.length != 0 &&
//                   _subCategories!.first.id != state.items!.first.id) {
//                 _subCategories!.addAll(state.items!);
//               } else if (_subCategories!.length == 0) {
//                 _subCategories!.addAll(state.items!);
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
//                       //         child: _categoryBloc.categories == null
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
//                       //                     _categoryBloc.categories!.length,
//                 itemBuilder: (context, index) {
//                   if (_categoryBloc
//                       .categories!.isNotEmpty) {
//                     return CategoryWidget(
//                         model: _categoryBloc
//                             .categories![index],
//                         onTap: () => onCategoryTap(
//                             _categoryBloc
//                                 .categories![index]));
//                   }
//                   return CategoryEmptyWidget();
//                 }))),

//                       Expanded(
//                           flex: 3,
//                           child: Container(
//                               padding: EdgeInsets.only(bottom: 40),
//                               decoration: BoxDecoration(
//                                   color: Color(0xffffffff),
//                                   border: Border.symmetric(
//                                       vertical: BorderSide(
//                                           color: Color(0xffeeeeee)))),
//                               child: _categoryBloc.categories == null
//                                   ? ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: BouncingScrollPhysics(),
//                                       itemCount: 6,
//                                       itemBuilder: (context, index) {
//                                         return CategoryEmptyWidget();
//                                       })
//                                   : ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: BouncingScrollPhysics(),
//                                       itemCount:
//                                           _categoryBloc.categories!.length,
//                                       itemBuilder: (context, index) {
//                                         if (_categoryBloc
//                                             .categories!.isNotEmpty) {
//                                           return CategoryWidget(
//                                               model: _categoryBloc
//                                                   .categories![index],
//                                               onTap: () => onCategoryTap(
//                                                   _categoryBloc
//                                                       .categories![index]));
//                                         }
//                                         return CategoryEmptyWidget();
//                                       }))),
//                       Expanded(
//                           flex: 7,
//                           child: Container(
//                             padding: EdgeInsets.only(bottom: 30),
//                             margin: EdgeInsets.only(left: 6, right: 8),
//                             child: Column(children: [
//                               _subCategories == null ||
//                                       _subCategories!.length == 0
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
//                                           ? _subCategories!.length
//                                           : (_subCategories!.first
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
//                                                     ? _subCategories![index]
//                                                         .subSubCategory!
//                                                         .length
//                                                     : (_subCategories![index]
//                                                                 .subSubCategory!
//                                                                 .length >
//                                                             10
//                                                         ? 10
//                                                         : (_subCategories![
//                                                                         index]
//                                                                     .subSubCategory!
//                                                                     .length >=
//                                                                 5
//                                                             ? 5
//                                                             : 1)),
//                                                 model: _subCategories![index]),
//                                             if (_subCategories![index]
//                                                         .subSubCategory!
//                                                         .length !=
//                                                     0 &&
//                                                 _subCategories![index]
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

//           return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Expanded(
//                 //     flex: 3,
//                 //     child: Container(
//                 //         padding: EdgeInsets.only(bottom: 40),
//                 //         decoration: BoxDecoration(
//                 //             color: Color(0xffffffff),
//                 //             border: Border.symmetric(
//                 //                 vertical: BorderSide(
//                 //                     color: Color(0xffeeeeee)))),
//                 //         child: _categoryBloc.categories == null
//                 //             ? ListView.builder(
//                 //                 shrinkWrap: true,
//                 //                 physics: BouncingScrollPhysics(),
//                 //                 itemCount: 6,
//                 //                 itemBuilder: (context, index) {
//                 //                   return CategoryEmptyWidget();
//                 //                 })
//                 //             : ListView.builder(
//                 //                 shrinkWrap: true,
//                 //                 physics: BouncingScrollPhysics(),
//                 //                 itemCount:
//                 //                     _categoryBloc.categories!.length,
//                 //                 itemBuilder: (context, index) {
//                 //                   if (_categoryBloc
//                 //                       .categories!.isNotEmpty) {
//                 //                     return CategoryWidget(
//                 //                         model: _categoryBloc
//                 //                             .categories![index],
//                 //                         onTap: () => onCategoryTap(
//                 //                             _categoryBloc
//                 //                                 .categories![index]));
//                 //                   }
//                 //                   return CategoryEmptyWidget();
//                 //                 }))),

//                 Expanded(
//                     flex: 3,
//                     child: Container(
//                         padding: EdgeInsets.only(bottom: 40),
//                         decoration: BoxDecoration(
//                             color: Color(0xffffffff),
//                             border: Border.symmetric(
//                                 vertical:
//                                     BorderSide(color: Color(0xffeeeeee)))),
//                         child: _categoryBloc.categories == null
//                             ? ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: BouncingScrollPhysics(),
//                                 itemCount: 6,
//                                 itemBuilder: (context, index) {
//                                   return CategoryEmptyWidget();
//                                 })
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: BouncingScrollPhysics(),
//                                 itemCount: _categoryBloc.categories!.length,
//                                 itemBuilder: (context, index) {
//                                   if (_categoryBloc.categories!.isNotEmpty) {
//                                     return CategoryWidget(
//                                         model:
//                                             _categoryBloc.categories![index],
//                                         onTap: () => onCategoryTap(
//                                             _categoryBloc.categories![index]));
//                                   }
//                                   return CategoryEmptyWidget();
//                                 }))),
//                 Expanded(
//                     flex: 7,
//                     child: Container(
//                       padding: EdgeInsets.only(bottom: 30),
//                       margin: EdgeInsets.only(left: 6, right: 8),
//                       child: Column(children: [
//                         _subCategories == null || _subCategories!.length == 0
//                             ? ListView.separated(
//                                 padding: EdgeInsets.symmetric(vertical: 12),
//                                 primary: false,
//                                 shrinkWrap: true,
//                                 itemCount: 4,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return SubCategoryEmptyWidget();
//                                 },
//                                 separatorBuilder:
//                                     (BuildContext context, int index) =>
//                                         SizedBox(height: 8))
//                             : ListView.separated(
//                                 padding: EdgeInsets.symmetric(vertical: 12),
//                                 primary: false,
//                                 shrinkWrap: true,
//                                 itemCount: _showRealLength == true
//                                     ? _subCategories!.length
//                                     : (_subCategories!
//                                                 .first.subSubCategory!.length >
//                                             6
//                                         ? 1
//                                         : 2),
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Stack(
//                                     alignment: Alignment.bottomRight,
//                                     children: [
//                                       SubCategoryWidget(
//                                           realLength: _showRealSubLengthIndex !=
//                                                       null &&
//                                                   _showRealSubLengthIndex ==
//                                                       index
//                                               ? _subCategories![index]
//                                                   .subSubCategory!
//                                                   .length
//                                               : (_subCategories![index]
//                                                           .subSubCategory!
//                                                           .length >
//                                                       10
//                                                   ? 10
//                                                   : (_subCategories![index]
//                                                               .subSubCategory!
//                                                               .length >=
//                                                           5
//                                                       ? 5
//                                                       : 1)),
//                                           model: _subCategories![index]),
//                                       if (_subCategories![index]
//                                                   .subSubCategory!
//                                                   .length !=
//                                               0 &&
//                                           _subCategories![index]
//                                                   .subSubCategory!
//                                                   .length >
//                                               3)
//                                         Align(
//                                           alignment: Alignment.bottomRight,
//                                           child: GestureDetector(
//                                               onTap: () async {
//                                                 setState(() {
//                                                   _showRealSubLengthIndex =
//                                                       index;
//                                                 });
//                                               },
//                                               child: Container(
//                                                 color: Colors.white,
//                                                 margin: EdgeInsets.symmetric(
//                                                     horizontal: 15.w,
//                                                     vertical: 20.h),
//                                                 child: RichText(
//                                                   softWrap: true,
//                                                   maxLines: 2,
//                                                   textAlign: TextAlign.center,
//                                                   text: TextSpan(children: [
//                                                     if (_showRealSubLengthIndex !=
//                                                         index)
//                                                       TextSpan(
//                                                         text: translate(
//                                                             "button.show_more"),
//                                                         style: TextStyle(
//                                                           color: Colors.blue
//                                                               .withOpacity(0.5),
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           decoration:
//                                                               TextDecoration
//                                                                   .underline,
//                                                           fontSize: 25.sp,
//                                                         ),
//                                                       ),
//                                                     TextSpan(text: " "),
//                                                   ]),
//                                                 ),
//                                               )),
//                                         ),
//                                     ],
//                                   );
//                                 },
//                                 separatorBuilder:
//                                     (BuildContext context, int index) =>
//                                         SizedBox(height: 8)),
//                       ]),
//                     ))
//               ]);
//         })));
//   }

//   onCategoryTap(CategoryModel categoryModel) {
//     if (_categoryBloc.categories!.first.selected == true) {
//       _categoryBloc.categories!.first.selected = false;
//     }
//     // setState(() {
//     if (_selectedCategory != null) {
//       _selectedCategory!.selected = false;
//     }
//     if (_subCategories != null) _subCategories!.clear();
//     setState(() {
//       _showRealLength = false;
//       _showRealSubLengthIndex = -100;
//       _categoryBloc.isPaginationFinished = false;
//       categoryModel.selected = !categoryModel.selected!;
//       _selectedCategory = categoryModel;
//       _categoryBloc.subCatPage = 1;
//     });
//     _categoryBloc
//         .add(FetchSubCategoriesEvent(categoryId: categoryModel.id.toString()));
//     // });
//   }
// }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:hand_bill/src/blocs/category/category_state.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_widget.dart';

// import '../../../../blocs/category/category_bloc.dart';
// import '../../../../blocs/category/category_event.dart';
// import '../../../../data/model/category/category.dart';
// import '../../../../data/model/category/sub_category.dart';
// import '../../../../data/model/local/drawer_model.dart';
// import '../../../component/widgets.dart';
// import 'component/category_widget.dart';
// import 'component/sub_category_empty_widget.dart';

// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   List<CategoryModel>? _categories;

//   List<SubCategoryModel>? _subCategories;

//   ScrollController? _scrollController;
//   double offsetVisibleThreshold = 100;

//   CategoryModel? _selectedCategory;
//   CategoryBloc? _categoryBloc;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   void initState() {
//     _categoryBloc = BlocProvider.of<CategoryBloc>(context);
//     if (_categoryBloc.categories == null ||
//         _categoryBloc.categories!.length == 0)
//       _categoryBloc.add(FetchCategoriesEvent());
//     if (_categoryBloc.subCategories == null ||
//         _categoryBloc.subCategories!.length == 0)
//       _categoryBloc
//         .add(FetchSubCategoriesEvent(
//             categoryId: _categoryBloc.categories!.first.id.toString()));
//     if (_categoryBloc.subCategories != null &&
//         _categoryBloc.categories!.length != 0) {
//       _subCategories = _categoryBloc.subCategories;
//     }
//     // SchedulerBinding.instance!.addPostFrameCallback((_) {
//     //   if (_categories != null) {
//     //     setState(() {
//     //       _categories![0].selected = true;
//     //       _selectedCategory = _categories![0];
//     //     });
//     //   }
//     // });
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
//     if (offset + offsetVisibleThreshold >= max && !_categoryBloc.isFetching) {
//       _categoryBloc.isFetching = true;
//       if (_selectedCategory == null)
//         _selectedCategory = _categoryBloc.categories!.first;
//       if (_showRealLength == false)
//         setState(() {
//           _showRealLength = true;
//         });
//       Timer(Duration(seconds: 6), () {
//         _categoryBloc.add(FetchSubCategoriesEvent(
//             categoryId: _selectedCategory!.id.toString()));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xfff5f5f5),
//         body: RefreshIndicator(
//           onRefresh: () async {},
//           child: BlocBuilder<CategoryBloc, CategoryState>(
//               builder: (context, state) {
//             if (state is CategoryErrorState) {
//               _categories = [];
//               SchedulerBinding.instance?.addPostFrameCallback((_) {
//                 displaySnackBar(title: state.errors, scaffoldKey: _scaffoldKey);
//               });
//             }
//             if (state is CategoriesSuccessState) {
//               if (_categories == null) {
//                 _categories = [];
//               } else {}
//             }
//             if (state is SubCategoriesSuccessState) {
//               if (_subCategories == null) {
//                 _subCategories = [];
//               }
//               if (_selectedCategory != null &&
//                   state.items != null &&
//                   state.items!.length != 0) {
//                 if (_showRealLength == false) {
//                   SchedulerBinding.instance?.addPostFrameCallback((_) {
//                     setState(() {
//                       _showRealLength = true;
//                     });
//                   });
//                 }
//                 if (_subCategories!.length != 0 &&
//                     _subCategories!.first.id != state.items!.first.id) {
//                   _subCategories!.addAll(state.items!);
//                 } else if (_subCategories!.length == 0) {
//                   _subCategories!.addAll(state.items!);
//                 }
//               }
//             }

//             return CustomScrollView(
//                 physics: BouncingScrollPhysics(),
//                 controller: _scrollController,
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           height: 70,
//                           // height: 160,
//                           // color: Colors.red,
//                           child: Directionality(
//                             textDirection: TextDirection.ltr,
//                             child: SizedBox(
//                               height: 50,
//                               child: ListView.separated(
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   if (_categoryBloc.categories!.isNotEmpty) {
//                                     return CategoryWidget(
//                                         model:
//                                             _categoryBloc.categories![index],
//                                         onTap: () => onCategoryTap(
//                                             _categoryBloc.categories![index]));
//                                   }
//                                   return CategoryEmptyWidget();
//                                 },
//                                 itemCount: _categoryBloc.categories!.length,
//                                 separatorBuilder:
//                                     (BuildContext context, int index) =>
//                                         SizedBox(
//                                   width: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Expanded(
//                         //     flex: 3,
//                         //     child: Container(
//                         //         padding: EdgeInsets.only(bottom: 40),
//                         //         decoration: BoxDecoration(
//                         //             color: Color(0xffffffff),
//                         //             border: Border.symmetric(
//                         //                 vertical:
//                         //                     BorderSide(color: Color(0xffeeeeee)))),
//                         //         child: _categoryBloc.categories == null
//                         //             ? ListView.builder(
//                         //                 shrinkWrap: true,
//                         //                 physics: BouncingScrollPhysics(),
//                         //                 itemCount: 6,
//                         //                 itemBuilder: (context, index) {
//                         //                   return CategoryEmptyWidget();
//                         //                 })
//                         //             : ListView.builder(
//                         //                 shrinkWrap: true,
//                         //                 physics: BouncingScrollPhysics(),
//                         //                 itemCount: _categoryBloc.categories!.length,
//                         //                 itemBuilder: (context, index) {
//                         //                   if (_categoryBloc.categories!.isNotEmpty) {
//                         //                     return CategoryWidget(
//                         //                         model:
//                         //                             _categoryBloc.categories![index],
//                         //                         onTap: () => onCategoryTap(
//                         //                             _categoryBloc.categories![index]));
//                         //                   }
//                         //                   return CategoryEmptyWidget();
//                         //                 }))),
//                         // Container(
//                         //   padding: EdgeInsets.only(bottom: 30),
//                         //   margin: EdgeInsets.only(left: 6, right: 8),
//                         //   child: Column(children: [
//                         //     _subCategories == null ||
//                         //             _subCategories!.length == 0
//                         //         ? ListView.separated(
//                         //             padding: EdgeInsets.symmetric(vertical: 12),
//                         //             primary: false,
//                         //             shrinkWrap: true,
//                         //             itemCount: 4,
//                         //             itemBuilder:
//                         //                 (BuildContext context, int index) {
//                         //               return SubCategoryEmptyWidget();
//                         //             },
//                         //             separatorBuilder:
//                         //                 (BuildContext context, int index) =>
//                         //                     SizedBox(height: 8))
//                         //         : ListView.separated(
//                         //             padding: EdgeInsets.symmetric(vertical: 12),
//                         //             primary: false,
//                         //             shrinkWrap: true,
//                         //             itemCount: _showRealLength == true
//                         //                 ? _subCategories!.length
//                         //                 : (_subCategories!.first.subSubCategory!
//                         //                             .length >
//                         //                         6
//                         //                     ? 1
//                         //                     : 2),
//                         //             itemBuilder:
//                         //                 (BuildContext context, int index) {
//                         //               return Stack(
//                         //                 alignment: Alignment.bottomRight,
//                         //                 children: [
//                         //                   SubCategoryWidget(
//                         //                       realLength: _showRealSubLengthIndex !=
//                         //                                   null &&
//                         //                               _showRealSubLengthIndex ==
//                         //                                   index
//                         //                           ? _subCategories![index]
//                         //                               .subSubCategory!
//                         //                               .length
//                         //                           : (_subCategories![index]
//                         //                                       .subSubCategory!
//                         //                                       .length >
//                         //                                   10
//                         //                               ? 10
//                         //                               : (_subCategories![index]
//                         //                                           .subSubCategory!
//                         //                                           .length >=
//                         //                                       5
//                         //                                   ? 5
//                         //                                   : 1)),
//                         //                       model: _subCategories![index]),
//                         //                   if (_subCategories![index]
//                         //                               .subSubCategory!
//                         //                               .length !=
//                         //                           0 &&
//                         //                       _subCategories![index]
//                         //                               .subSubCategory!
//                         //                               .length >
//                         //                           3)
//                         //                     Align(
//                         //                       alignment: Alignment.bottomRight,
//                         //                       child: GestureDetector(
//                         //                           onTap: () async {
//                         //                             setState(() {
//                         //                               _showRealSubLengthIndex =
//                         //                                   index;
//                         //                             });
//                         //                           },
//                         //                           child: Container(
//                         //                             color: Colors.white,
//                         //                             margin:
//                         //                                 EdgeInsets.symmetric(
//                         //                                     horizontal: 15.w,
//                         //                                     vertical: 20.h),
//                         //                             child: RichText(
//                         //                               softWrap: true,
//                         //                               maxLines: 2,
//                         //                               textAlign:
//                         //                                   TextAlign.center,
//                         //                               text: TextSpan(children: [
//                         //                                 if (_showRealSubLengthIndex !=
//                         //                                     index)
//                         //                                   TextSpan(
//                         //                                     text: translate(
//                         //                                         "button.show_more"),
//                         //                                     style: TextStyle(
//                         //                                       color: Colors.blue
//                         //                                           .withOpacity(
//                         //                                               0.5),
//                         //                                       fontWeight:
//                         //                                           FontWeight
//                         //                                               .bold,
//                         //                                       decoration:
//                         //                                           TextDecoration
//                         //                                               .underline,
//                         //                                       fontSize: 25.sp,
//                         //                                     ),
//                         //                                   ),
//                         //                                 TextSpan(text: " "),
//                         //                               ]),
//                         //                             ),
//                         //                           )),
//                         //                     ),
//                         //                 ],
//                         //               );
//                         //             },
//                         //             separatorBuilder:
//                         //                 (BuildContext context, int index) =>
//                         //                     SizedBox(height: 8)),
//                         //   ]),
//                         // ),
//                       ],
//                     ),
//                   )
//                 ]);
//           }),
//         ));
//   }

//   onCategoryTap(CategoryModel categoryModel) {
//     if (_categoryBloc.categories!.first.selected == true) {
//       _categoryBloc.categories!.first.selected = false;
//     }
//     // setState(() {
//     if (_selectedCategory != null) {
//       _selectedCategory!.selected = false;
//     }
//     if (_subCategories != null) _subCategories!.clear();
//     setState(() {
//       _showRealLength = false;
//       _showRealSubLengthIndex = -100;
//       _categoryBloc.isPaginationFinished = false;
//       categoryModel.selected = !categoryModel.selected!;
//       _selectedCategory = categoryModel;
//       _categoryBloc.subCatPage = 1;
//     });
//     _categoryBloc
//         .add(FetchSubCategoriesEvent(categoryId: categoryModel.id.toString()));
//     // });
//   }
// }
////////////////////////////////////////////////////////////////////////////////
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/blocs/category/category_state.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_widget.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/sub_category_screen.dart';

import '../../../../blocs/category/category_bloc.dart';
import '../../../../blocs/category/category_event.dart';
import '../../../../data/model/category/category.dart';
import '../../../../data/model/category/sub_category.dart';
import '../../../../data/model/local/drawer_model.dart';
import '../../../../data/model/local/route_argument.dart';
import '../../../component/custom/login_first_widget_sliver.dart';
import '../../../component/widgets.dart';
import 'component/category_widget.dart';
import 'component/sub_cat.dart';
import 'component/sub_category_empty_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  List<CategoryModel>? _categories;

  List<SubCategoryModel>? _subCategories;

  ScrollController? _scrollController;
  double offsetVisibleThreshold = 100;

  CategoryModel? _selectedCategory;
  late CategoryBloc _categoryBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (_categoryBloc.categories == null ||
        _categoryBloc.categories!.length == 0)
      _categoryBloc.add(FetchCategoriesEvent());
    // if (_categoryBloc.subCategories == null ||
    //     _categoryBloc.subCategories!.length == 0)
    //   _categoryBloc
    //     .add(FetchSubCategoriesEvent(
    //         categoryId: _categoryBloc.categories!.first.id.toString()));
    // if (_categoryBloc.subCategories != null &&
    //     _categoryBloc.categories!.length != 0) {
    //   _subCategories = _categoryBloc.subCategories;
    // }
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   if (_categories != null) {
    //     setState(() {
    //       _categories![0].selected = true;
    //       _selectedCategory = _categories![0];
    //     });
    //   }
    // });
    // _scrollController = ScrollController().addListener(_onScroll);
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
  //   if (offset + offsetVisibleThreshold >= max && !_categoryBloc.isFetching) {
  //     _categoryBloc.isFetching = true;
  //     if (_selectedCategory == null)
  //       _selectedCategory = _categoryBloc.categories!.first;
  //     if (_showRealLength == false)
  //       setState(() {
  //         _showRealLength = true;
  //       });
  //     Timer(Duration(seconds: 6), () {
  //       _categoryBloc.add(FetchSubCategoriesEvent(
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
          child: BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryErrorState) {
                _categories = [];
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  displaySnackBar(
                      title: state.errors, scaffoldKey: _scaffoldKey);
                });
              }
              if (state is CategoriesSuccessState) {
                if (_categories == null) {
                  _categories = [];
                } else {}
              }
              if (state is SubCategoriesSuccessState) {
                if (_subCategories == null) {
                  _subCategories = [];
                }
                if (_selectedCategory != null &&
                    state.items != null &&
                    state.items!.length != 0) {
                  if (_showRealLength == false) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _showRealLength = true;
                      });
                    });
                  }
                  if (_subCategories!.length != 0 &&
                      _subCategories!.first.id != state.items!.first.id) {
                    _subCategories!.addAll(state.items!);
                  } else if (_subCategories!.length == 0) {
                    _subCategories!.addAll(state.items!);
                  }
                }
              }
            },

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
                      List.generate(_categoryBloc.categories!.length, (index) {
                    return CategoryWidget(
                        model: _categoryBloc.categories![index],
                        onTap: () =>
                            onCategoryTap(_categoryBloc.categories![index]));
                  })),
              SizedBox(height: 80),
            ]),
            // child: CustomScrollView(
            //     physics: BouncingScrollPhysics(),
            //     controller: _scrollController,
            //     slivers: [
            //       SliverToBoxAdapter(
            //         child: GridView.builder(
            //           // scrollDirection: Axis.vertical,

            //           shrinkWrap: true,
            //           itemBuilder: (context, index) {
            //             if (_categoryBloc.categories!.isNotEmpty) {
            //               return CategoryWidget(
            //                   model: _categoryBloc.categories![index],
            //                   onTap: () => onCategoryTap(
            //                       _categoryBloc.categories![index]));
            //             }
            //             return CategoryEmptyWidget();
            //           },
            //           itemCount: _categoryBloc.categories!.length,
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
    //                     if (_categoryBloc.categories!.isNotEmpty) {
    //                       return CategoryWidget(
    //                           model: _categoryBloc.categories![index],
    //                           onTap: () => onCategoryTap(
    //                               _categoryBloc.categories![index]));
    //                     }
    //                     return CategoryEmptyWidget();
    //                   },
    //                   itemCount: _categoryBloc.categories!.length,
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
    CategoryModel categoryModel,
  ) {
    if (_categoryBloc.categories!.first.selected == true) {
      _categoryBloc.categories!.first.selected = false;
    }
    // setState(() {
    if (_selectedCategory != null) {
      _selectedCategory!.selected = false;
    }
    if (_subCategories != null) _subCategories!.clear();
    setState(() {
      _showRealLength = false;
      _showRealSubLengthIndex = -100;
      // _categoryBloc.isPaginationFinished = false;
      categoryModel.selected = !categoryModel.selected!;
      _selectedCategory = categoryModel;
      _categoryBloc.subCatPage = 1;

      Navigator.pushNamed(context, SubCategories.routeName,
          arguments: RouteArgument(
              param: categoryModel.name.toString(),
              id: categoryModel.id.toString()));
    });
    _categoryBloc
        .add(FetchSubCategoriesEvent(categoryId: categoryModel.id.toString()));
    // });
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
// import 'dart:async';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:hand_bill/src/blocs/category/category_bloc.dart';
// import 'package:hand_bill/src/blocs/category/category_event.dart';
// import 'package:hand_bill/src/blocs/category/category_state.dart';
// import 'package:hand_bill/src/data/model/category/category.dart';
// import 'package:hand_bill/src/data/model/category/sub_category.dart';
// import 'package:hand_bill/src/ui/component/widgets.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_empty_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/category_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_empty_widget.dart';
// import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_category_widget.dart';

// class CategoriesScreen extends StatefulWidget {
//   @override
//   _CategoriesScreenState createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   List<CategoryModel>? _categories;

//   List<SubCategoryModel>? _subCategories;

//   ScrollController? _scrollController;
//   double offsetVisibleThreshold = 100;

//   CategoryModel? _selectedCategory;
//   CategoryBloc? _categoryBloc;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     _categoryBloc = BlocProvider.of<CategoryBloc>(context);
//     if (_categoryBloc.categories == null ||
//         _categoryBloc.categories!.length == 0)
//       _categoryBloc.add(FetchCategoriesEvent());
//     if (_categoryBloc.subCategories == null ||
//         _categoryBloc.subCategories!.length == 0)
//       _categoryBloc
//         .add(FetchSubCategoriesEvent(
//             categoryId: _categoryBloc.categories!.first.id.toString()));
//     if (_categoryBloc.subCategories != null &&
//         _categoryBloc.categories!.length != 0) {
//       _subCategories = _categoryBloc.subCategories;
//     }
//     // SchedulerBinding.instance!.addPostFrameCallback((_) {
//     //   if (_categories != null) {
//     //     setState(() {
//     //       _categories![0].selected = true;
//     //       _selectedCategory = _categories![0];
//     //     });
//     //   }
//     // });
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
//     if (offset + offsetVisibleThreshold >= max && !_categoryBloc.isFetching) {
//       _categoryBloc.isFetching = true;
//       if (_selectedCategory == null)
//         _selectedCategory = _categoryBloc.categories!.first;
//       if (_showRealLength == false)
//         setState(() {
//           _showRealLength = true;
//         });
//       Timer(Duration(seconds: 6), () {
//         _categoryBloc.add(FetchSubCategoriesEvent(
//             categoryId: _selectedCategory!.id.toString()));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//           if (state is SubCategoriesSuccessState) {
//             if (_subCategories == null) {
//               _subCategories = [];
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
//               if (_subCategories!.length != 0 &&
//                   _subCategories!.first.id != state.items!.first.id) {
//                 _subCategories!.addAll(state.items!);
//               } else if (_subCategories!.length == 0) {
//                 _subCategories!.addAll(state.items!);
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
//                       //         child: _categoryBloc.categories == null
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
//                       //                     _categoryBloc.categories!.length,
//                       //                 itemBuilder: (context, index) {
//                       //                   if (_categoryBloc
//                       //                       .categories!.isNotEmpty) {
//                       //                     return CategoryWidget(
//                       //                         model: _categoryBloc
//                       //                             .categories![index],
//                       //                         onTap: () => onCategoryTap(
//                       //                             _categoryBloc
//                       //                                 .categories![index]));
//                       //                   }
//                       //                   return CategoryEmptyWidget();
//                       //                 }))),
//                       Expanded(
//                           flex: 3,
//                           child: Container(
//                               padding: EdgeInsets.only(bottom: 40),
//                               decoration: BoxDecoration(
//                                   color: Color(0xffffffff),
//                                   border: Border.symmetric(
//                                       vertical: BorderSide(
//                                           color: Color(0xffeeeeee)))),
//                               child: _categoryBloc.categories == null
//                                   ? ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: BouncingScrollPhysics(),
//                                       itemCount: 6,
//                                       itemBuilder: (context, index) {
//                                         return CategoryEmptyWidget();
//                                       })
//                                   : ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: BouncingScrollPhysics(),
//                                       itemCount:
//                                           _categoryBloc.categories!.length,
//                                       itemBuilder: (context, index) {
//                                         if (_categoryBloc
//                                             .categories!.isNotEmpty) {
//                                           return CategoryWidget(
//                                               model: _categoryBloc
//                                                   .categories![index],
//                                               onTap: () => onCategoryTap(
//                                                   _categoryBloc
//                                                       .categories![index]));
//                                         }
//                                         return CategoryEmptyWidget();
//                                       }))),
//                       Expanded(
//                           flex: 7,
//                           child: Container(
//                             padding: EdgeInsets.only(bottom: 30),
//                             margin: EdgeInsets.only(left: 6, right: 8),
//                             child: Column(children: [
//                               _subCategories == null ||
//                                       _subCategories!.length == 0
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
//                                           ? _subCategories!.length
//                                           : (_subCategories!.first
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
//                                                     ? _subCategories![index]
//                                                         .subSubCategory!
//                                                         .length
//                                                     : (_subCategories![index]
//                                                                 .subSubCategory!
//                                                                 .length >
//                                                             10
//                                                         ? 10
//                                                         : (_subCategories![
//                                                                         index]
//                                                                     .subSubCategory!
//                                                                     .length >=
//                                                                 5
//                                                             ? 5
//                                                             : 1)),
//                                                 model: _subCategories![index]),
//                                             if (_subCategories![index]
//                                                         .subSubCategory!
//                                                         .length !=
//                                                     0 &&
//                                                 _subCategories![index]
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
//     if (_categoryBloc.categories!.first.selected == true) {
//       _categoryBloc.categories!.first.selected = false;
//     }
//     // setState(() {
//     if (_selectedCategory != null) {
//       _selectedCategory!.selected = false;
//     }
//     if (_subCategories != null) _subCategories!.clear();
//     setState(() {
//       _showRealLength = false;
//       _showRealSubLengthIndex = -100;
//       _categoryBloc.isPaginationFinished = false;
//       categoryModel.selected = !categoryModel.selected!;
//       _selectedCategory = categoryModel;
//       _categoryBloc.subCatPage = 1;
//     });
//     _categoryBloc
//         .add(FetchSubCategoriesEvent(categoryId: categoryModel.id.toString()));
//     // });
//   }
// }
