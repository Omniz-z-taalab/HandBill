import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

import 'dart:ui' as ui;

import 'package:hand_bill/src/data/model/chats/chat.dart';
import 'package:hand_bill/src/data/model/user.dart';

class MessageWidget extends StatelessWidget {
  final Chat? model;
  final User? user;

  MessageWidget({this.model, this.user});

  double radius = 900;

  // Color mainColor = mainColor;

  @override
  Widget build(BuildContext context) {
    return user!.id == model!.userId
        ? SendMessageLayout(context)
        : RecivedMessageLayout(context);
  }

  Widget SendMessageLayout(context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
            // mainAxisSize: MainAxisSize.min,
            // textDirection: ui.TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xff2D71D9),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              topRight: Radius.circular(radius),
                              bottomLeft: Radius.circular(radius))),
                      child: Text(
                        model!.text.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white),
                        textAlign: TextAlign.end,
                      )))
            ]));
  }

  Widget RecivedMessageLayout(context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
            textDirection: ui.TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border.all(color: Color(0xffeeeeee)),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              topRight: Radius.circular(radius),
                              bottomRight: Radius.circular(radius))),
                      child: Text(model!.text.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: textDarkColor))))
            ]));
  }
}
