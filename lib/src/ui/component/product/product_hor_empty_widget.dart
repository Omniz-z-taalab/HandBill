import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class ProductHorEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              width: constraints.maxHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Theme.of(context).hoverColor)),
              child: Column(            crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                Container(
                  height: constraints.maxHeight * 0.60,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: shimmerColor),
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxHeight * 0.4,
                                  color: shimmerColor),
                              Container(
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxHeight * 0.7,
                                  color: shimmerColor)
                            ])))
              ]));
        });
  }
}
