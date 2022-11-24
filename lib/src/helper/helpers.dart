import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Helper {
  static chaneStatusBarColor(
      {required Color statusBarColor, required Brightness brightness}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: brightness,
        statusBarBrightness: brightness));
  }

  static AlignmentDirectional getAlignmentDirectional(
      String? alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static Color getColorFromHex(String hex) {
    if (hex.contains('#')) {
      return Color(int.parse(hex.replaceAll("#", "0xFF")));
    } else {
      return Color(int.parse("0xFF" + hex));
    }
  }
}
