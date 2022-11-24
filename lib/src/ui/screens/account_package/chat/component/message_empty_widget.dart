import 'package:flutter/material.dart';


class MessageEmptyWidget extends StatelessWidget {
  double radius = 900;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                      bottomRight: Radius.circular(radius))),
              child: Text("                ",
                  style: Theme.of(context).textTheme.headline1))
        ]));
  }
}
