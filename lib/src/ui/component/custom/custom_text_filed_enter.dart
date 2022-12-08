import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class CustomTextFormFieldEnter extends StatefulWidget {
  bool isPassword;
  bool isEmail;
  String? hintText;
  TextEditingController? controller;
  var validator;
  IconData? icon;
  Function(String?)? onSave;
  double radius = 12;
  Color? fillColor;
  Color? borderColor;

  CustomTextFormFieldEnter(
      {this.isPassword = false,
      this.isEmail = false,
      this.hintText,
      this.controller,
      this.validator,
      this.icon,
      this.onSave,
      this.fillColor = const Color(0xffffffff),
      this.borderColor = const Color(0xffe0e0e0)});

  @override
  _CustomTextFormFieldEnterState createState() =>
      _CustomTextFormFieldEnterState();
}

class _CustomTextFormFieldEnterState extends State<CustomTextFormFieldEnter> {
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
      maxLines: 10,
      keyboardType: widget.isEmail?TextInputType.emailAddress:TextInputType.text,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: textLiteColor),
          // hintStyle: Te,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                  // width: 1,
                  color: widget.borderColor!,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                  color: widget.borderColor!, style: BorderStyle.solid)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide:
                  BorderSide(color: Colors.red, style: BorderStyle.solid)),
          fillColor: widget.fillColor,
          filled: true),
      controller: widget.controller,
      validator: widget.validator,
      onSaved: (input) => widget.onSave!(input),
    );
  }
}



class CustomTextFormFieldtitle extends StatefulWidget {
  bool isPassword;
  bool isEmail;
  String? hintText;
  TextEditingController? controller;
  var validator;
  IconData? icon;
  Function(String?)? onSave;
  double radius = 12;
  Color? fillColor;
  Color? borderColor;

  CustomTextFormFieldtitle(
      {this.isPassword = false,
        this.isEmail = false,
        this.hintText,
        this.controller,
        this.validator,
        this.icon,
        this.onSave,
        this.fillColor = const Color(0xffffffff),
        this.borderColor = const Color(0xffe0e0e0)});

  @override
  _CustomTextFormFieldtitleState createState() =>
      _CustomTextFormFieldtitleState();
}

class _CustomTextFormFieldtitleState extends State<CustomTextFormFieldtitle> {
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
      maxLines: null,
      keyboardType: widget.isEmail?TextInputType.emailAddress:TextInputType.text,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: textLiteColor),
          // hintStyle: Te,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                // width: 1,
                  color: widget.borderColor!,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                  color: widget.borderColor!, style: BorderStyle.solid)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide:
              BorderSide(color: Colors.red, style: BorderStyle.solid)),
          fillColor: widget.fillColor,
          filled: true),
      controller: widget.controller,
      validator: widget.validator,
      onSaved: (input) => widget.onSave!(input),
    );
  }
}
