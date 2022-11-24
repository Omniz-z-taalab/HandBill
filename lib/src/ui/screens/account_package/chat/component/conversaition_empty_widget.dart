import 'package:flutter/material.dart';


class ConversationEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double shimmerHeight = MediaQuery.of(context).size.height * 0.02;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Container(
              height: width * 0.18,
              width: width * 0.18,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).hoverColor)),
          SizedBox(width: 16),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    height: shimmerHeight,
                    width: width * 0.4,
                    color: Theme.of(context).hoverColor),
                SizedBox(height: shimmerHeight),
                Container(
                    height: shimmerHeight,
                    width: width * 0.25,
                    color: Theme.of(context).hoverColor)
              ]))
        ]));
  }
}
