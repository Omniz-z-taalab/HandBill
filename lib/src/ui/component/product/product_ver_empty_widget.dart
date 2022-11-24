import 'package:flutter/material.dart';

class ProductVerEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 4 / 3,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Theme.of(context).hoverColor)),
                  child: Stack(fit: StackFit.loose, children: [
                    Container(
                        height: constraints.maxHeight * 0.65,
                        width: double.infinity,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Theme.of(context).hoverColor,
                            borderRadius: BorderRadius.circular(16.0))),
                    Positioned(
                        height: constraints.maxHeight * 0.35,
                        bottom: 0,
                        width: constraints.maxWidth,
                        child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: constraints.maxHeight * 0.1,
                                      width: constraints.maxWidth * 0.3,
                                      color: Theme.of(context).hoverColor),
                                  SizedBox(height: constraints.maxHeight * 0.05),
                                  Container(
                                      height: constraints.maxHeight * 0.1,
                                      width: constraints.maxWidth * 0.7,
                                      color: Theme.of(context).hoverColor)
                                ])))
                  ]));
            }));
  }
}
