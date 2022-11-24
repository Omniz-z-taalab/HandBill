// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:hand_bill/src/common/constns.dart';
// import 'package:hand_bill/src/data/model/about_us/aboutUsModel.dart';

// class AboutUsWidget extends StatelessWidget {
//   final AboutUsModel model;
//   final Function? onTap;

//   AboutUsWidget({required this.model, this.onTap});

//   late final double imgSize;

//   @override
//   Widget build(BuildContext context) {
//     imgSize = MediaQuery.of(context).size.height * 0.07;
//     return InkWell(
//         onTap: () => onTap!(),
//         child: Padding(
//             padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//             child: Column(children: [
//               Row(children: [
//                 Container(
//                     clipBehavior: Clip.hardEdge,
//                     height: imgSize,
//                     width: imgSize,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(900),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color(0xffeeeeee),
//                               blurRadius: 3,
//                               spreadRadius: 3)
//                         ]),
//                     child: CachedNetworkImage(
//                         fit: BoxFit.cover,
//                         imageUrl: model.name!,
//                         placeholder: (context, url) => FittedBox(
//                             child: Transform.scale(
//                                 scale: 0.2,
//                                 child: CircularProgressIndicator(
//                                     color: mainColorLite, strokeWidth: 2))),
//                         errorWidget: (context, url, error) =>
//                             new Icon(Icons.error, color: mainColorLite))),
//                 SizedBox(width: 16),
//                 Expanded(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                       Text(model.name!,
//                           style: TextStyle(color: textDarkColor, fontSize: 15)),
//                       SizedBox(height: 4),
//                       Text(model.title!,
//                           style: TextStyle(color: textLiteColor, fontSize: 14))
//                     ])),
//                 SizedBox(width: 16),
//                 Icon(
//                   Icons.email,
//                   // color: Color(0xffE0E0E0),
//                   color: mainColor,
//                 )
//               ]),
//               Container(
//                   height: 0.5,
//                   margin: EdgeInsets.only(top: 16),
//                   color: Color(0xffe0e0e0))
//             ])));
//   }
// }
