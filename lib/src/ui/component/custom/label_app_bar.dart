import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:hand_bill/src/data/model/user.dart';

class LabelAppBar extends PreferredSize {
  String? title;
  double height, padding;
  MainAxisAlignment? mainAxisAlignment;
  bool center;
  Color? bgColor;
  Color textColor;

  double btnSize = 42;
  FontWeight fontWeight;

  LabelAppBar(
      {this.title,
      this.padding = 16,
      this.center = false,
      this.bgColor,
      this.textColor = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.height = kToolbarHeight})
      : super(child: Container(), preferredSize: Size(0, 0));

  @override
  Size get preferredSize => Size.fromHeight(height);

  User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: preferredSize.height,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration:
            BoxDecoration(color: bgColor ?? Theme.of(context).backgroundColor),
        child: Row(
            textDirection: ui.TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      height: btnSize,
                      width: btnSize,
                      padding: EdgeInsets.all(btnSize * 0.32),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).primaryColor),
                      child: Icon(Icons.arrow_back_ios))),
              center == false
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Text(title!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5)),
              center
                  ? SizedBox(width: 40)
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Text(title!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5))
            ]));
  }
}
