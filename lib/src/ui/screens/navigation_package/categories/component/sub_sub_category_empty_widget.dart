import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/data/model/category/sub_sub_category.dart';
import 'package:hand_bill/src/ui/screens/details_package/subcategory_products/products_screen.dart';

class SubSubCategoryEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xffffffff),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Center(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Image.asset(
                        "assets/images/loading.gif",
                        fit: BoxFit.cover,
                      ))),
              SizedBox(height: 6),
              Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text("",
                                style: TextStyle(
                                    color: textDarkColor, fontSize: 11),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center))
                      ]))
            ]));
  }
}
