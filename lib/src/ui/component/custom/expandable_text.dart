import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final int length;

  ExpandableTextWidget({required this.text, this.length = 180});

  @override
  _ExpandableTextWidgetState createState() => new _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ExpandableTextWidget oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  init() {
    if (widget.text.length > widget.length) {
      firstHalf = widget.text.substring(0, widget.length);
      secondHalf = widget.text.substring(widget.length, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf,
              style: TextStyle(fontSize: 15, color: textDarkColor))
          : new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 15, color: textDarkColor),
                          children: [
                        TextSpan(
                            text: flag
                                ? (firstHalf + "...")
                                : (firstHalf + secondHalf)),
                        TextSpan(
                            text: flag ? '   show more' : '   show less',
                            style: TextStyle(
                                fontSize: 14,
                                color: mainColorLite,
                                fontWeight: FontWeight.normal),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => setState(() => flag = !flag))
                      ]))
                ]),
    );
  }
}
