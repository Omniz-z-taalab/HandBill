import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/model/helpcenterMode/help-model.dart';

Widget HelpCenter(HelpCenterModel mails) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade400,blurRadius: 4,spreadRadius: 3),
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.centerLeft,
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
