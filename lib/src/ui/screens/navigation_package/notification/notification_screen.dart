// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:hand_bill/src/blocs/Services/states.dart';
// import 'package:hand_bill/src/blocs/notification/notifications_bloc.dart';
//
// import 'package:hand_bill/src/data/model/company.dart';
// import 'package:hand_bill/src/data/model/notification_model.dart';
// import 'package:hand_bill/src/ui/component/custom/login_first_widget_sliver.dart';
// import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';
//
// import '../../../../blocs/Companies/bloc.dart';
// import '../../../../blocs/Services/Event.dart';
// import '../../../../blocs/company/company_bloc.dart';
// import '../../../../blocs/search/search_bloc.dart';
// import '../../../../blocs/search/search_event.dart';
// import '../../../../blocs/search/search_state.dart';
// import '../../../../common/constns.dart';
// import '../../../../data/model/Search_data.dart';
// import '../../../../data/model/ServiceCategory/serviceCategory.dart';
// import '../../../../data/model/category/category.dart';
// import '../../../../data/model/serviceCategories_model.dart';
// import 'component/notification_widget.dart';
//
// class SearchCompanyScreen extends StatefulWidget {
//
//   @override
//   _SearchCompanyScreenState createState() => _SearchCompanyScreenState();
// }
//
// class _SearchCompanyScreenState extends State<SearchCompanyScreen>
//     with TickerProviderStateMixin {
//   List<NotificationModel>? _items;
//
//   NotificationsBloc? _notificationsBloc;
//   ScrollController? _scrollController;
//   static const offsetVisibleThreshold = 50.0;
//   bool loading = false;
//   SearchBloc? _searchBloc;
//   List<Company>? data;
//
//   bool isFetching = false;
//   final _searchController = TextEditingController();
//
//   final double size = 20;
//   int selectedPage = 0;
//   FocusNode focusNode = FocusNode();
//   ServiceBloc? _serviceBloc;
//   List<CategoryModel>? items;
//    List<ServiceCategoryModel>? category;
//
//   @override
//   void didChangeDependencies() {
//     _serviceBloc = BlocProvider.of<ServiceBloc>(context);
//     _serviceBloc!..add(FetchServiceEvent());
//     // _searchBloc = BlocProvider.of<SearchBloc>(context);
//     // _searchBloc!..add(SearchMarketEvent(searchKey: _searchController.text));
//     super.didChangeDependencies();
//   }
//
//   @override
//   void initState() {
//      // _serviceBloc = BlocProvider.of<ServiceBloc>(context);
//      // _serviceBloc!..add(FetchServiceEvent());
//     // _searchBloc = BlocProvider.of<SearchBloc>(context);
//     // _searchBloc!..add(SearchMarketEvent(searchKey: _searchController.text));
//     // // _notificationsBloc!.page = 1;
//     // // _notificationsBloc!.add(NotificationsFetchEvent());
//     // // _scrollController = ScrollController()..addListener(_onScroll);
//
//     super.initState();
//   }
//
//   // @override
//   // void dispose() {
//   //   _scrollController!.dispose();
//   //   super.dispose();
//   // }
//   //
//   // void _onScroll() {
//   //   final max = _scrollController!.position.maxScrollExtent;
//   //   final offset = _scrollController!.offset;
//   //
//   //   if (offset + offsetVisibleThreshold >= max &&
//   //       !_notificationsBloc!.isFetching) {
//   //     setState(() {
//   //       _notificationsBloc!.isFetching = true;
//   //     });
//   //     _notificationsBloc!.add(NotificationsFetchEvent());
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     _onSubmitted(value) async {
//       if (_searchController.text.length >= 3) {
//         if (selectedPage == 0) {
//           _searchBloc!..add(SearchMarketEvent(searchKey: value));
//         }
//       }
//     }
//
//     Color borderColor = Color(0xffeeeeee);
//
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             ),
//           ),
//           backgroundColor: Colors.white,
//           title: Container(
//             width: 370,
//             height: 40,
//             child: TextField(
//                 textAlignVertical: TextAlignVertical.center,
//                 onChanged: (value) {
//                   _onSubmitted(value.trim());
//                   _searchBloc!
//                     ..add(SearchMarketEvent(searchKey: _searchController.text));
//                 },
//                 style: TextStyle(color: textLiteColor),
//                 decoration: InputDecoration(
//                     prefixIcon: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: SvgPicture.asset("assets/icons/search_ic.svg",
//                             height: size, width: size)),
//                     hintText: translate("search.suppliers"),
//                     filled: true,
//                     focusColor: mainColor,
//                     hintStyle: Theme.of(context).textTheme.headline2,
//                     fillColor: Color(0xffffffff),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(90),
//                         borderSide: BorderSide(color: borderColor, width: 1)),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(color: borderColor, width: 1))),
//                 controller: _searchController,
//                 textInputAction: TextInputAction.go,
//                 onSubmitted: (value) => _onSubmitted(value.trim()),
//                 focusNode: focusNode),
//           )),
//       body: BlocProvider(
//         create: (_) => ServiceBloc(context: context),
//         child: BlocConsumer<ServiceBloc, ServiceState>(
//             listener: (BuildContext context, state) {
//           if (state is CategoriesAddSuccessState) {
//             category = state.items!;
//           }
//         }, builder: (context, state) {
//           return CustomScrollView(
//               physics: BouncingScrollPhysics(),
//               reverse: true,
//               controller: _scrollController,
//               slivers: [
//                 data == null
//                     ? LoadingSliver()
//                     : data!.length == 0
//                         ? CenterWidgetListSliver(label: "search is empty")
//                         : SliverToBoxAdapter(
//                             child: Column(children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   'Search by Company',
//                                   style: TextStyle(
//                                       color: Colors.grey.shade500,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 620,
//                               child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Container(
//                                     height: 100,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade500),
//                                         borderRadius: BorderRadius.circular(20)),
//                                     child: ListView.separated(
//                                       itemBuilder: (context, index) =>
//                                           SearchCompany(data![index]),
//                                       itemCount: data!.length!,
//                                       separatorBuilder:
//                                           (BuildContext context, int index) =>
//                                               Container(
//                                         width: double.infinity,
//                                         height: 1,
//                                         color: Colors.grey.shade500,
//                                       ),
//                                     ),
//                                   )),
//                             ),
//                             Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Colors.grey.shade500),
//                                         borderRadius: BorderRadius.circular(20)),
//                                     child: SizedBox(
//                                       height: 600,
//                                       child: ListView.separated(
//                                         itemBuilder: (context, index) =>
//                                             CategoryCompany(items![index]),
//                                         itemCount: 3,
//                                         separatorBuilder:
//                                             (BuildContext context, int index) =>
//                                                 Container(
//                                           width: double.infinity,
//                                           height: 1,
//                                           color: Colors.grey.shade500,
//                                         ),
//                                       ),
//                                     )))
//                           ]))
//               ]);
//         }),
//       ),
//     );
//   }
// }
//
// Widget SearchCompany(Company company) {
//   return InkWell(onTap: () {
//     print('omniaaaaaaaaaaaaaaa');
//     print(company.id);
//     // Navigator.pushNamed(context, SubCategoriesScreen.routeName,
//     //     arguments: RouteArgument(param: model.id));
//   }, child: LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Row(
//         children: [
//           Expanded(
//               child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               company.name!,
//               style: TextStyle(color: Colors.black),
//             ),
//           )),
//           IconButton(
//               onPressed: () {
//                 // Navigator.pushNamed(context, SubCategoriesScreen.routeName,
//                 //     arguments: RouteArgument(param: model.id));
//               },
//               icon: Icon(Icons.arrow_forward_ios))
//         ],
//       ),
//     );
//   }));
// }
//
// Widget CategoryCompany(CategoryModel model) {
//   return InkWell(onTap: () {
//     print('omniaaaaaaaaaaaaaaa');
//     print(model.id);
//     // Navigator.pushNamed(context, SubCategoriesScreen.routeName,
//     //     arguments: RouteArgument(param: model.id));
//   }, child: LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Row(
//         children: [
//           Expanded(
//               child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               model.name!,
//               style: TextStyle(color: Colors.black),
//             ),
//           )),
//           IconButton(
//               onPressed: () {
//                 // Navigator.pushNamed(context, SubCategoriesScreen.routeName,
//                 //     arguments: RouteArgument(param: model.id));
//               },
//               icon: Icon(Icons.arrow_forward_ios))
//         ],
//       ),
//     );
//   }));
// }
