import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_bill/src/common/constns.dart';

class IconBtnWithCounter extends StatelessWidget {
  IconBtnWithCounter(
      {required this.icon,
      required this.press,
      this.numOfItem = 0,
      this.btnSize = 42,
      this.icSizeSize = 16,
      this.radius = 12,
      this.padding,
      this.backgroundColor,
      this.iconColor});

  final IconData icon;
  final int? numOfItem;
  final GestureTapCallback press;
  double? btnSize, icSizeSize, radius, padding;

  Color? backgroundColor, iconColor;
  Color shadowColor = Color(0x80e9edf2);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(radius!),
        child: InkWell(
            onTap: press,
            child: Stack(children: [
              Container(
                  height: btnSize,
                  width: btnSize,
                  padding: EdgeInsets.all(padding ?? btnSize! * 0.28),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius!),
                      color: backgroundColor ?? Theme.of(context).primaryColor),
                  child: Icon(icon,
                      color: iconColor ?? Theme.of(context).primaryColorLight)),
              if (numOfItem != 0)
                Positioned(
                    child: Container(
                        alignment: Alignment.center,
                        height: icSizeSize,
                        width: icSizeSize,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: const Color(0xffff4848),
                            border:
                                Border.all(width: 1.14, color: Colors.white)),
                        child: Center(
                            child: Text(numOfItem.toString(),
                                style: TextStyle(
                                  fontFamily: '',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.white,
                                )))))
            ])));
  }
}
