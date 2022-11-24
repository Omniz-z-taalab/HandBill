// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:hand_bill/src/data/model/local/drawer_model.dart';
// import 'package:hand_bill/src/ui/component/items/drawer_item_widget.dart';
// import 'package:hand_bill/src/ui/screens/services_package/asstes/assets_screen.dart';
// import 'package:hand_bill/src/ui/screens/services_package/auctions/auctions_screen.dart';
// import 'package:hand_bill/src/ui/screens/services_package/hand_made/hand_made_screen.dart';
// import 'package:hand_bill/src/ui/screens/services_package/jobs/companies_jobs_screen.dart';
// import 'package:hand_bill/src/ui/screens/services_package/offers/offers_screen.dart';
// import 'package:hand_bill/src/ui/screens/services_package/patented/patents_screen.dart';
// import 'package:hand_bill/src/ui/screens/services_package/shipping/shipping_screen.dart';

// class ServicesScreen extends StatefulWidget {
//   @override
//   _ServicesScreenState createState() => _ServicesScreenState();
// }

// class _ServicesScreenState extends State<ServicesScreen> {
//   List<DrawerModel> _items = [];

//   @override
//   void didChangeDependencies() {
//      _items.clear();
//     _items.add(DrawerModel(
//         title: translate("categories.jobs"),
//         icon: "assets/icons/account/job_search.svg",
//         onTap: () => Navigator.pushNamed(context, CompaniesJobsScreen.routeName)));
//     _items.add(DrawerModel(
//         title: translate("categories.auctions"),
//         icon: "assets/icons/account/auction.svg",
//         onTap: ()=> Navigator.pushNamed(context, AuctionsScreen.routeName)));
//     _items.add(DrawerModel(
//         title: translate("categories.offers"),
//         icon: "assets/icons/account/sale_tag.svg",
//         onTap: () => Navigator.pushNamed(context, OffersScreen.routeName)));
//     _items.add(DrawerModel(
//         title: translate("categories.assets"),
//         icon: "assets/icons/account/asset.svg",
//         onTap: ()=> Navigator.pushNamed(context, AssetsScreen.routeName)));
//     _items.add(DrawerModel(
//         title: translate("categories.patented"),
//         icon: "assets/icons/account/certificate.svg",
//         onTap: () => Navigator.pushNamed(context, PatentsScreen.routeName)));
//     _items.add(DrawerModel(
//         title: translate("categories.hand_made"),
//         icon: "assets/icons/account/handmade.svg",
//         onTap: () => Navigator.pushNamed(context, HandmadeScreen.routeName)));
//     _items.add(DrawerModel(
//         title: translate("categories.shipping_customs_broker"),
//         icon: "assets/icons/account/delivery_truck.svg",
//         onTap: () => Navigator.pushNamed(context, ShippingScreen.routeName)));
//     // _items.add(DrawerModel(
//     //     title: "",
//     //     icon: "assets/images/businessman.png",
//     //     onTap: () => Navigator.pushNamed(context, CustomsScreen.routeName)));
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//             child: Column(children: [
//                 SizedBox(height: 16),
//                 GridView.count(
//                     padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
//                     childAspectRatio: 1 / 0.7,
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 2,
//                     mainAxisSpacing: 2,
//                     shrinkWrap: true,
//                     primary: false,
//                     children: List.generate(_items.length, (index) {
//                       return DrawerItemWidget(model: _items[index]);
//                     }),
//                 )
//     ])));
//   }
// }
