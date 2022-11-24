import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/notification/notification_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/search_screen.dart';

import '../../search/search_service/screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double size = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.12,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/hb_logo.jpeg",
                                height: 32),
                            Row(children: [
                              SizedBox(width: 20),
                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchSuppliers())),
                                child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/search_ic.svg",
                                          height: size,
                                          width: size)
                                    ]),
                              )
                            ])
                          ]))),
              Container(
                  width: double.infinity, color: Color(0xffeeeeee), height: 1.5)
            ]));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
