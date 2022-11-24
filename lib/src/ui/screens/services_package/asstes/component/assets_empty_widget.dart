import 'package:flutter/material.dart';

class AssetsEmptyWidget extends StatelessWidget {
  final double size = 45;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 5 / 1,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).hoverColor)),
                SizedBox(width: 16),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(),
                      Container(
                          height: constraints.maxHeight * 0.15,
                          width: constraints.maxWidth * 0.4,
                          color: Theme.of(context).hoverColor),
                      Container(
                          height: constraints.maxHeight * 0.15,
                          width: constraints.maxWidth * 0.25,
                          color: Theme.of(context).hoverColor),
                      SizedBox()
                    ]))
              ]));
        }));
  }
}
