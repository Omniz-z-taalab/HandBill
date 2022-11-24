import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';

class ServerImageWidget extends StatelessWidget {
  final String image;
  final Function? onTap;
  final Function? onRemoveTap;

  ServerImageWidget({required this.image, this.onTap, this.onRemoveTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap!(),
        child: Stack(children: [
          Positioned.fill(
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) => FittedBox(
                      child: Transform.scale(
                          scale: 0.2,
                          child: CircularProgressIndicator(
                              color: mainColorLite, strokeWidth: 2))),
                  errorWidget: (context, url, error) =>
                      new Icon(Icons.error, color: mainColorLite))),
          Positioned(
              top: 12,
              right: 12,
              child: InkWell(
                  onTap: () => onRemoveTap!(),
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color(0x26000000),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Icon(Icons.close, color: Colors.white)))))
        ]));
  }
}

class LocalImageWidget extends StatelessWidget {
  final File image;
  final Function? onTap;
  final Function? onRemoveTap;

  LocalImageWidget({required this.image, this.onTap, this.onRemoveTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap!(),
        child: Stack(children: [
          Positioned.fill(child: Image.file(image, fit: BoxFit.cover)),
          Positioned(
              top: 12,
              right: 12,
              child: InkWell(
                  onTap: () => onRemoveTap!(),
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color(0x26000000),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Icon(Icons.close, color: Colors.white)))))
        ]));
  }
}
