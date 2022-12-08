import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/screens/details_package/subcategory_products/products_screen.dart';

import '../../../../../data/model/category/sub_sub.dart';

class SubSubCategoryWidget extends StatelessWidget {
  final SubSubCategoryModelData? model;

  SubSubCategoryWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
            padding: EdgeInsets.all(5),
            child: InkWell(
                onTap: () {

                  Navigator.pushNamed(context, ProductsScreen.routeName,
                      arguments: RouteArgument(param: model));
                },
                child: Material(
                  color: Color(0xffffffff),
                  child: Row(

                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: model!.image != null
                                    ? CachedNetworkImage(
                                        imageUrl: '${APIData.domainLink}${model!.image!.thump!}',
                                        // height: 60.h,
                                        // width: 60.w,
                                        // fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            heightFactor: 1,
                                            widthFactor: 1,
                                            child: Image.asset(
                                              "assets/images/loading.gif",
                                              fit: BoxFit.cover,
                                            )),
                                      )
                                    : Image.asset(
                                        "assets/images/hb_logo.jpeg",
                                        fit: BoxFit.contain,
                                      )),
                            SizedBox(height: 6),
                            Flexible(
                                child: Container(
                                    padding: new EdgeInsets.only(right: 13.0),
                                    child:
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                      Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 6),
                                          child: SizedBox(
                                            height: 24,
                                            child: Text(model!.name ?? "Name".tr(),
                                                style: TextStyle(
                                                    color: textDarkColor,
                                                    fontSize: 11),
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.center),
                                          ))
                                    ))
                          ]),
                    ],
                  ),
                ))));
  }
}
