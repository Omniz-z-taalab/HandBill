import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/services/job_user_model.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/services_package/jobs/jobs_user_details_screens.dart';
import 'package:timeago/timeago.dart' as timeago;

class JobUserWidget extends StatelessWidget {
  final JobUserModel model;
  final Function? onRemoveTap;
  final bool? isMy;

  JobUserWidget({required this.model, this.onRemoveTap, this.isMy = false});

  @override
  Widget build(BuildContext context) {
    double imgSize = MediaQuery.of(context).size.width * 0.15;
    return InkWell(
        onTap: () => Navigator.pushNamed(
            context, JobUserDetailsScreen.routeName,
            arguments: RouteArgument(param: model, check: isMy)),
        child: Material(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Color(0xffeeeeee)))),
                child: Column(children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      child: Row(children: [
                                        Container(
                                            height: imgSize,
                                            width: imgSize,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Color(0xffe0e0e0))),
                                            child: CachedNetworkImage(
                                                imageUrl: model.user!.image ==
                                                        null
                                                    ? placeholder
                                                    :
                                                        model.user!.image!.url!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Transform.scale(
                                                        scale: 0.4,
                                                        child: CircularProgressIndicator(
                                                            color:
                                                                mainColorLite,
                                                            strokeWidth: 2)),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    new Icon(Icons.error,
                                                        color: mainColorLite))),
                                        SizedBox(width: 12),
                                        Expanded(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              Text(model.user!.name.toString(),
                                                  style: TextStyle(
                                                      color: textDarkColor,
                                                      fontSize: 14)),
                                              SizedBox(height: 6),
                                              Text(
                                                  model.user!.address
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: textDarkColor,
                                                      fontSize: 14)),
                                            ])),
                                      ]))),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    onRemoveTap == null
                                        ? SizedBox()
                                        : Material(
                                            color: Colors.white,
                                            child: IconButton(
                                                onPressed: () => onRemoveTap!(),
                                                icon: Icon(Icons.close,
                                                    color: Color(0xffBDBDBD)))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 16,
                                            top: onRemoveTap == null ? 16 : 0),
                                        child: Text(
                                            timeago.format(model.dateTime!),
                                            style: TextStyle(
                                                color: textDarkColor,
                                                fontSize: 11))),
                                  ])
                            ]),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(model.title.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(height: 16)
                      ]),
                ]))));
  }
}
