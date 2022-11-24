import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function? onPress;
  final double radius;
  Color? color;
  Color borderColor;
  double borderWidth;
  double? width;
  double verticalPadding;
  double horizontalPadding;
  TextStyle? textStyle;

  CustomButton(
      {this.title,
      this.onPress,
      this.color,
      this.borderColor = Colors.transparent,
      this.borderWidth = 1,
      this.width,
      this.radius = 0,
      this.verticalPadding = 16,
      this.horizontalPadding = 24,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress as void Function()?,
        child: width == null
            ? Container(
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: color ?? Theme.of(context).accentColor,
                    border: Border.all(color: borderColor, width: borderWidth)),
                child: Center(
                    child: Text(title!,
                        style: TextStyle(fontSize: 17, fontWeight:FontWeight.w500, color: Colors.white)
                            .merge(textStyle),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)))
            : Container(
                width: width,
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: color ?? Theme.of(context).accentColor,
                    border: Border.all(color: borderColor, width: borderWidth)),
                child: Center(
                    child: Text(title!,
                        style: TextStyle(
                                fontSize: 17,
                                fontWeight:FontWeight.w500,
                                color: Colors.white)
                            .merge(textStyle),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis))));
  }
}
