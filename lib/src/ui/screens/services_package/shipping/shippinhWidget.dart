import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/company.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/common/services_company/services_company_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/model/services/companies.dart';

class ShapWidget extends StatelessWidget {
  final Data model;

  ShapWidget({required this.model});

  final double marginHor = 16, marginBetween = 8;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          print('[[[[[[[[[[[[[[[[');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServicesCompanyDetailsScreen(
                        name: model.name.toString(),
                        adresses: model.address.toString(),
                        logo:  model!.logo == null
                            ? placeholder
                            :model!.logo!.thump!,
                        // model.logo!.thump!.toString(),
                        email: model.email.toString(),
                        phone: model.phone.toString(),
                        website: model.website.toString(),
                        whatsapp: model.whatsApp.toString(),
                      )));
        },
        child: Container(
            color: Colors.white54,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 10,
                        blurRadius: 1,
                        color: Colors.white
                    )
                  ]
              ),
              child: Column(children: [
                Stack(children: [
                  Container(
                      height: size.width * 0.4,
                      width: double.infinity,

                      margin:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: Card(
                          clipBehavior: Clip.hardEdge,
                          // elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          // ignore: unnecessary_null_comparison
                          child:
                               CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl:
                                  model!.logo == null
                                   ? placeholder
                                  :'${APIData.domainLink}${model!.logo!.thump!}',
                                  placeholder: (context, url) => FittedBox(
                                      child: Transform.scale(
                                          scale: 0.2,
                                          child: CircularProgressIndicator(
                                              color: mainColorLite,
                                              strokeWidth: 2))),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error, color: mainColorLite))
                              // : Container(
                              //     child: Image.asset(
                              //       "assets/images/Hbill.jpeg",
                              //       // height: 60,
                              //       // width: 20,
                              //     ),
                              //   )
                          // CachedNetworkImage(
                          //     imageUrl: model.images == null
                          //         ? model.logo!.url!
                          //         : model.images!.isEmpty
                          //             ? placeholder
                          //             : (model.images![0].url != null
                          //                 ? model.images![0].url!
                          //                 : model.images![0].icon!),
                          //     fit: BoxFit.cover,
                          //     placeholder: (context, url) => Transform.scale(
                          //         scale: 0.4,
                          //         child: CircularProgressIndicator(
                          //             color: mainColorLite, strokeWidth: 2)),
                          //     errorWidget: (context, url, error) =>
                          //         new Icon(Icons.error)),
                          )),
                  Positioned(
                      height: size.width * 0.18,
                      width: size.width * 0.18,
                      bottom: 0,
                      child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Card(
                              clipBehavior: Clip.hardEdge,
                              // elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: model.flag.toString() == null
                                  ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: model.flag!,
                                      placeholder: (context, url) => FittedBox(
                                          child: Transform.scale(
                                              scale: 0.2,
                                              child: CircularProgressIndicator(
                                                  color: mainColorLite,
                                                  strokeWidth: 2))),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error,
                                              color: mainColorLite))
                                  : Image.asset(
                                      "assets/images/Hbill.jpeg",
                                      height: 60,
                                      // width: 20,
                                    )
                              // CachedNetworkImage(
                              //     imageUrl: model.logo == null
                              //         ? placeholder
                              //         : model.logo!.url!,
                              //     fit: BoxFit.cover,
                              //     placeholder: (context, url) => Transform.scale(
                              //         scale: 0.4,
                              //         child: CircularProgressIndicator(
                              //             color: mainColorLite, strokeWidth: 2)),
                              //     errorWidget: (context, url, error) =>
                              //         new Icon(Icons.error))
                              )))
                ]),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 16),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: marginHor),
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(model.name!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1),
                                      SizedBox(height: 6),
                                      Text(model.country.toString(),
                                          style: TextStyle(
                                              color: textDarkColor,
                                              fontSize: 14)),
                                      SizedBox(height: 6),
                                      // Text(
                                      //     model.leftDataOfCompanies == null
                                      //         ? "Shipping Company"
                                      //         : model.leftDataOfCompanies!
                                      //                     .companyInfo ==
                                      //                 null
                                      //             ? "Shipping Company"
                                      //             : model.leftDataOfCompanies!
                                      //                 .companyInfo
                                      //                 .toString(),
                                      //     style: TextStyle(
                                      //         color: textDarkColor, fontSize: 14))
                                    ])),
                                SizedBox(width: marginHor),
                                // Container(
                                //     height: 24,
                                //     width: 24,
                                //     child: CachedNetworkImage(
                                //         fit: BoxFit.cover,
                                //         imageUrl: model.flag!,
                                //         placeholder: (context, url) => FittedBox(
                                //             child: Transform.scale(
                                //                 scale: 0.2,
                                //                 child: CircularProgressIndicator(
                                //                     color: mainColorLite,
                                //                     strokeWidth: 2))),
                                //         errorWidget: (context, url, error) =>
                                //             new Icon(Icons.error,
                                //                 color: mainColorLite)))
                              ]),
                          SizedBox(height: 10.h)
                        ])),
              ]),
            )));
    // return InkWell(
    //     onTap: () {},
    //     //  Navigator.pushNamed(
    //     //     context, ServicesCompanyDetailsScreen.routeName,
    //     //     arguments: RouteArgument(param: model.id)),
    //     child: Container(
    //         color: Color(0xffffffff),
    //         child: Column(children: [
    //           Stack(children: [
    //             // Container(
    //             //     height: size.width * 0.4,
    //             //     width: size.width * 0.8,
    //             //     margin:
    //             //         EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
    //             //     child: Card(
    //             //       clipBehavior: Clip.hardEdge,
    //             //       // elevation: 3,
    //             //       shape: RoundedRectangleBorder(
    //             //           borderRadius: BorderRadius.circular(8)),
    //             //       child: CachedNetworkImage(
    //             //           imageUrl: model == null
    //             //               ? model.data?.first.logo
    //             //               : model.data!.first.flag!.isEmpty
    //             //                   ? placeholder
    //             //                   : (model.images![0].url != null
    //             //                       ? model.images![0].url!
    //             //                       : model.images![0].icon!),
    //             //           fit: BoxFit.cover,
    //             //           placeholder: (context, url) => Transform.scale(
    //             //               scale: 0.4,
    //             //               child: CircularProgressIndicator(
    //             //                   color: mainColorLite, strokeWidth: 2)),
    //             //           errorWidget: (context, url, error) =>
    //             //               new Icon(Icons.error)),
    //             //     )),
    //             Positioned(
    //                 height: size.width * 0.18,
    //                 width: size.width * 0.18,
    //                 bottom: 0,
    //                 child: AspectRatio(
    //                     aspectRatio: 1 / 1,
    //                     child: Card(
    //                         clipBehavior: Clip.hardEdge,
    //                         // elevation: 3,
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(8)),
    //                         child: CachedNetworkImage(
    //                             imageUrl: model.logo == null
    //                                 ? placeholder
    //                                 // ignore: dead_code
    //                                 : model.logo?.url,
    //                             fit: BoxFit.cover,
    //                             placeholder: (context, url) => Transform.scale(
    //                                 scale: 0.4,
    //                                 child: CircularProgressIndicator(
    //                                     color: mainColorLite, strokeWidth: 2)),
    //                             errorWidget: (context, url, error) =>
    //                                 new Icon(Icons.error)))))
    //           ]),
    //           Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 16),
    //               child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.stretch,
    //                   children: [
    //                     SizedBox(height: 16),
    //                     Row(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           SizedBox(width: marginHor),
    //                           Expanded(
    //                               child: Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                 Text(model.name.toString(),
    //                                     style: TextStyle(
    //                                         color: Colors.black,
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.bold),
    //                                     maxLines: 1),
    //                                 SizedBox(height: 6),
    //                                 Text(model.country.toString(),
    //                                     style: TextStyle(
    //                                         color: textDarkColor,
    //                                         fontSize: 14)),
    //                                 SizedBox(height: 6),
    //                                 // Text(
    //                                 //     model.leftDataOfCompanies == null
    //                                 //         ? "Shipping Company"
    //                                 //         : model.leftDataOfCompanies!
    //                                 //                     .companyInfo ==
    //                                 //                 null
    //                                 //             ? "Shipping Company"
    //                                 //             : model.leftDataOfCompanies!
    //                                 //                 .companyInfo
    //                                 //                 .toString(),
    //                                 //     style: TextStyle(
    //                                 //         color: textDarkColor, fontSize: 14))
    //                               ])),
    //                           SizedBox(width: marginHor),
    //                           Container(
    //                               height: 24,
    //                               width: 24,
    //                               child: CachedNetworkImage(
    //                                   fit: BoxFit.cover,
    //                                   imageUrl: model.flag!,
    //                                   placeholder: (context, url) => FittedBox(
    //                                       child: Transform.scale(
    //                                           scale: 0.2,
    //                                           child: CircularProgressIndicator(
    //                                               color: mainColorLite,
    //                                               strokeWidth: 2))),
    //                                   errorWidget: (context, url, error) =>
    //                                       new Icon(Icons.error,
    //                                           color: mainColorLite)))
    //                         ]),
    //                     SizedBox(height: 10.h)
    //                   ])),
    //         ])));
  }
}
