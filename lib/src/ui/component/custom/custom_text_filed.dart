import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class CustomTextFormField extends StatefulWidget {
  bool isPassword;
  bool isEmail;
  String? hintText;
  TextEditingController? controller;
  var validator;
  IconData? icon;

  Function(String?)? onSave;

  CustomTextFormField(
      {this.isPassword = false,
      this.isEmail = false,
      this.hintText,
      this.controller,
      this.validator,
      this.icon,
      this.onSave});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Color fillColor = Colors.white;
  Color borderColor = Color(0xffBDBDBD);
  Color iconColor = Color(0xff707070);
  double icSize = 32;
  bool hide = false;

  @override
  void initState() {
    super.initState();
    hide = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.headline1,
      obscureText: hide,
      keyboardType:
          widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: borderColor)),
          enabledBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(color: borderColor)),
          // contentPadding: EdgeInsets.all(0),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: textLiteColor)),
      controller: widget.controller,
      validator: widget.validator,
      onSaved: (input) => widget.onSave!(input),
    );
  }
}
