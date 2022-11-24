import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {required this.icon,
      required this.press,
      this.btnSize,
      this.radius = 12,
      this.padding,
      this.backgroundColor,
      this.iconColor});

  final IconData icon;
  final GestureTapCallback press;
  double? btnSize, radius, padding;
  Color? backgroundColor, iconColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xeeeeee),
        borderRadius: BorderRadius.circular(radius!),
        child: InkWell(
            onTap: press,
            child: Container(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                height: btnSize,
                width: btnSize,
                padding: EdgeInsets.all(padding ?? 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius!),
                    border: Border.all(color: borderColor ?? Color(0xffeeeeee)),
                    color: backgroundColor ?? Color(0xeeeeee)),
                child:
                    Center(child: Icon(icon, color: iconColor ?? mainColor)))));
  }
}
