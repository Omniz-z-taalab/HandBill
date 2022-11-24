import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class HomeLabel extends StatelessWidget {
  final String title;

  HomeLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: mainColorLite,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width * 0.1,
                      color: mainColorLite)
                ])));
  }
}
