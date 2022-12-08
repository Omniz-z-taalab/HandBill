import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/constns.dart';
import '../../../../../data/model/helpcenterMode/help-model.dart';
 // late final double? imgSize;
// late final double imgSize;
//
// Widget HelpCenter(HelpCenterModel mails,context, Function? onTap
// ) {
//   // imgSize = MediaQuery.of(context).size.height * 0.07;
//
//   // imgSize = MediaQuery.of(context).size.height * 0.07;
//   return InkWell(
//        onTap: () => onTap!(),
//       child: Padding(
//           padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//           child: Column(children: [
//             Container(
//               child: Row(children: [
//
//                 SizedBox(width: 16),
//                 Expanded(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 4),
//                           Text(mails.email!,
//                               style: TextStyle(color: Colors.black54, fontSize: 14))
//                         ])),
//                 SizedBox(width: 16),
//                 Icon(
//                   Icons.email,
//                   // color: Color(0xffE0E0E0),
//                   color: mainColor,
//                 )
//               ]),
//             ),
//             Container(
//                 height: 0.5,
//                 margin: EdgeInsets.only(top: 16),
//                 color: Color(0xffe0e0e0))
//           ])));}



          class HelpCenter extends StatelessWidget {
            final Function? onTap;
            HelpCenterModel mails;
            HelpCenter({required this.mails, this.onTap});

            late final double imgSize;


            @override
            Widget build(BuildContext context) {
              imgSize = MediaQuery.of(context).size.height * 0.07;

              return  InkWell(
                  onTap: () => onTap!(),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(children: [
                        Container(
                          child: Row(children: [

                            SizedBox(width: 16),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(mails.email!,
                                          style: TextStyle(color: Colors.black54, fontSize: 14))
                                    ])),
                            SizedBox(width: 16),
                            Icon(
                              Icons.email,
                              // color: Color(0xffE0E0E0),
                              color: mainColor,
                            )
                          ]),
                        ),
                        Container(
                            height: 0.5,
                            margin: EdgeInsets.only(top: 16),
                            color: Color(0xffe0e0e0))
                      ])));

          }
          }
