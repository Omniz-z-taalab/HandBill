import 'package:flutter/material.dart';

class PatentedEmptyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.25;
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(height: height, width: double.infinity),
          Container(
              color: Color(0xfffafafa), height: 2, width: double.infinity),
          Padding(
              padding: EdgeInsets.only(left: 16),
              child: Row(children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Text("",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start))),
              ]))
        ]));
  }
}
