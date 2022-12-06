import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/model/helpcenterMode/help-model.dart';
late final double imgSize;

Widget HelpCenter(HelpCenterModel mails,context) {
  imgSize = MediaQuery.of(context).size.height * 0.07;

  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      clipBehavior: Clip.hardEdge,
      height: imgSize,
      width: imgSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(900),
          boxShadow: [
            BoxShadow(
                color: Color(0xffeeeeee),
                blurRadius: 3,
                spreadRadius: 3)
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 20),
                   
                      child: Text(
                        mails!.email!,
                        style: TextStyle(color: Colors.black54,fontSize: 20),

                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon( mails!.icon != null? mails.icon : Icons.email, color: Colors.black26),
          ),
        ],
      ),
    ),
  );
}
