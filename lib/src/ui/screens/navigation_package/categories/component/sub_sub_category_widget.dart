import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductsScreen.routeName,
              arguments: RouteArgument(param: model));
        },
        child: Material(
            color: Color(0xffffffff),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 4,
                      child: model!.image != null
                          ? CachedNetworkImage(
                              imageUrl: '${model!.image!.thump!}',
                              // height: 160.h,
                              // width: 210.w,
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
                  Expanded(
                      flex: 1,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: SizedBox(
                                  height: 24,
                                  child: Text(model!.name ?? "name",
                                      style: TextStyle(
                                          color: textDarkColor, fontSize: 11),
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.center),
                                ))
                          ]))
                ])));
  }
}
