import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/component/sub_sub_category_empty_widget.dart';

class SubCategoryEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xffeeeeee))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text("",
                  style: TextStyle(
                      // color: mainColorLite,
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500))),
          Container(
              height: 1.5,
              margin: EdgeInsets.only(bottom: 8),
              color: Color(0xfff5f5f5)),
          GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              childAspectRatio: 1 / 1.2,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              primary: false,
              children: List.generate(2, (index) {
                return SubSubCategoryEmptyWidget();
              })),
          SizedBox(height: 8)
        ]));
  }
}
