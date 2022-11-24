import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class CategoryEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.1,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
            heightFactor: 0.5,
            widthFactor: 0.5,
            child: CircularProgressIndicator(
                color: mainColorLite, strokeWidth: 1)));
  }
}
