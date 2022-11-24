import 'package:flutter/material.dart';

class DrawerModel {
  String? title;
  Function? onTap;
  Color? color;
  String? icon;

  DrawerModel({this.title, this.onTap, this.color, this.icon});
}
