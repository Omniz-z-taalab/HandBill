import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget widget;

  CustomPageRoute({required this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.elasticOut);
              return ScaleTransition(
                  alignment: Alignment.center, scale: animation, child: child);
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget;
            });
}
