import 'package:flutter/material.dart';

class MarketEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 4 /4,
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
                    height: constraints.maxHeight * 0.60,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Theme.of(context).hoverColor)),
                Positioned(
                    height: constraints.maxHeight * 0.40,
                    bottom: 0,
                    width: constraints.maxWidth,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: constraints.maxHeight * 0.05,
                                  width: constraints.maxWidth * 0.3,
                                  color: Theme.of(context).hoverColor),
                              SizedBox(height: constraints.maxHeight * 0.05),
                              Container(
                                  height: constraints.maxHeight * 0.05,
                                  width: constraints.maxWidth * 0.6,
                                  color: Theme.of(context).hoverColor),
                              Spacer(),
                              Expanded(
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                    marketOption(context: context),
                                    marketOption(context: context),
                                    marketOption(context: context)
                                  ]))
                            ])))
              ]));
        }));
  }

  Widget marketOption({required BuildContext context}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(6)),
    ));
  }
}
