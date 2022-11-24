// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:hand_bill/src/data/model/category/sub_category.dart';
// // import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_sub_category_widget.dart';

// // class SubSubCategoryWidget extends StatelessWidget {
// //   final SubCategoryModel model;
// //   final realLength;

// //   SubSubCategoryWidget({required this.model, required this.realLength});
// //   @override
// //   Widget build(BuildContext context) {
// //     return model.subSubCategory!.length != 0
// //         ? Container(
// //             decoration: BoxDecoration(
// //                 color: Color(0xffffffff),
// //                 borderRadius: BorderRadius.circular(8),
// //                 border: Border.all(color: Color(0xffeeeeee))),
// //             child:
// //                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //               Padding(
// //                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //                   child: Text(model.name!,
// //                       style: TextStyle(
// //                           color: Colors.black,
// //                           fontSize: 13,
// //                           fontWeight: FontWeight.w500))),
// //               Container(
// //                   height: 1.5,
// //                   margin: EdgeInsets.only(bottom: 8),
// //                   color: Color(0xfff5f5f5)),
// //               GridView.count(
// //                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// //                   childAspectRatio: 1 / 1.2,
// //                   crossAxisCount: 2,
// //                   crossAxisSpacing: 8,
// //                   mainAxisSpacing: 16,
// //                   shrinkWrap: true,
// //                   primary: false,
// //                   children: List.generate(this.realLength, (index) {
// //                     return SubSubSubCategoryWidget(
// //                         model: model.subSubCategory![index]);
// //                   })),
// //               SizedBox(height: 10)
// //             ]))
// //         : SizedBox();
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hand_bill/src/common/constns.dart';
// import 'package:hand_bill/src/common/global.dart';
// import 'package:hand_bill/src/data/model/category/category.dart';

// class SubCategoryWidget extends StatefulWidget {
//   final model;
//   // final Function onTap;
//   final index;
//   SubCategoryWidget({
//     required this.model,
//     required this.index,
//   });

//   @override
//   State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
// }

// class _SubCategoryWidgetState extends State<SubCategoryWidget> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: () {
       
//       },
//       child: Card(
//           elevation: 5,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.model.name,
//                         style: model.name == ''
//                             ? TextStyle(
//                                 color: mainColorLite,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12)
//                             : TextStyle(
//                                 color: textDarkColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                         maxLines: 3,
//                         textAlign: TextAlign.center,
//                         overflow: TextOverflow.ellipsis)
//                   ]))),
//     );

//     // InkWell(
//     //     onTap: () => onTap(),
//     //     child: Container(
//     //         // height: size.height * 0.1,
//     //         decoration: BoxDecoration(
//     //           color: Color(0xfff5f5f5),

//     //           // model.selected == true ? Color(0xfffafafa) : Colors.white
//     //         ),
//     //         child: Column(children: [
//     //           Padding(
//     //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//     //               child: Column(
//     //                   mainAxisAlignment: MainAxisAlignment.center,
//     //                   children: [
//     //                     Icon(
//     //                       Icons.add_circle_rounded,
//     //                       color: Colors.green,
//     //                     ),
//     //                     SizedBox(
//     //                       height: 5,
//     //                     ),
//     //                     Text(model.name!,
//     //                         style: model.selected == true
//     //                             ? TextStyle(
//     //                                 color: mainColorLite,
//     //                                 fontWeight: FontWeight.w500,
//     //                                 fontSize: 12)
//     //                             : TextStyle(color: textDarkColor, fontSize: 12),
//     //                         maxLines: 3,
//     //                         textAlign: TextAlign.center,
//     //                         overflow: TextOverflow.ellipsis)
//     //                   ])),
//     //           // model.selected == true
//     //           //     ? Container(width: 3, color: mainColorLite)
//     //           //     : SizedBox(),
//     //         ])));
//   }
// }

// // class SubCategoryWidget extends StatelessWidget {
// //   final model;
// //   // final Function onTap;
// //   final index;
// //   SubCategoryWidget({
// //     required this.model,
// //     required this.index,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     return InkWell(
// //       onTap: () {

// //         selectedIndex = index;
// //       },
// //       child: Card(
// //           elevation: 5,
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //           child: Padding(
// //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
// //               child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(model.name,
// //                         style: selectedIndex == index
// //                             ? TextStyle(
// //                                 color: mainColorLite,
// //                                 fontWeight: FontWeight.w500,
// //                                 fontSize: 12)
// //                             : TextStyle(
// //                                 color: textDarkColor,
// //                                 fontWeight: FontWeight.w500,
// //                               ),
// //                         maxLines: 3,
// //                         textAlign: TextAlign.center,
// //                         overflow: TextOverflow.ellipsis)
// //                   ]))),
// //     );

// //     // InkWell(
// //     //     onTap: () => onTap(),
// //     //     child: Container(
// //     //         // height: size.height * 0.1,
// //     //         decoration: BoxDecoration(
// //     //           color: Color(0xfff5f5f5),

// //     //           // model.selected == true ? Color(0xfffafafa) : Colors.white
// //     //         ),
// //     //         child: Column(children: [
// //     //           Padding(
// //     //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
// //     //               child: Column(
// //     //                   mainAxisAlignment: MainAxisAlignment.center,
// //     //                   children: [
// //     //                     Icon(
// //     //                       Icons.add_circle_rounded,
// //     //                       color: Colors.green,
// //     //                     ),
// //     //                     SizedBox(
// //     //                       height: 5,
// //     //                     ),
// //     //                     Text(model.name!,
// //     //                         style: model.selected == true
// //     //                             ? TextStyle(
// //     //                                 color: mainColorLite,
// //     //                                 fontWeight: FontWeight.w500,
// //     //                                 fontSize: 12)
// //     //                             : TextStyle(color: textDarkColor, fontSize: 12),
// //     //                         maxLines: 3,
// //     //                         textAlign: TextAlign.center,
// //     //                         overflow: TextOverflow.ellipsis)
// //     //                   ])),
// //     //           // model.selected == true
// //     //           //     ? Container(width: 3, color: mainColorLite)
// //     //           //     : SizedBox(),
// //     //         ])));
// //   }
// // }
