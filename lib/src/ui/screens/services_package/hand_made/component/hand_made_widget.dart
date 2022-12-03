import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/handmade_model.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/hand_made_details_screen.dart';

class HandmadeWidget extends StatelessWidget {
  final HandmadeModel model;
  final Function? onDeleteTap;
  final bool? isMy;

  HandmadeWidget({required this.model, this.onDeleteTap, this.isMy = false});

  final double marginVer = 16, marginBetween = 8;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.3;
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, HandmadeDetailsScreen.routeName,
              arguments: RouteArgument(param: model, check: isMy));
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(children: [
              CachedNetworkImage(
                  imageUrl:"${model.images![0].thump}",
                width: 200,height: 200,),
              Container(
                  color: Color(0xfffafafa), height: 2, width: double.infinity),
              Row(children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(model.title.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start),
                              SizedBox(height: 8),
                              Row(children: [
                                Expanded(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text("Price :".tr(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Text("${model.price} \$",
                                          style: TextStyle(
                                              color: textLiteColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ])),
                              ])
                            ]))),
                onDeleteTap == null
                    ? SizedBox()
                    : Material(
                        color: Colors.white,
                        child: IconButton(
                            onPressed: () => onDeleteTap!(),
                            icon: Icon(Icons.close, color: Color(0xffBDBDBD))))
              ])
            ])));
  }
}
