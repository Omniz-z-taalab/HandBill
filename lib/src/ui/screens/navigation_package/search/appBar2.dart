import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/search_screen.dart';

class MyAppBarSearch extends StatelessWidget implements PreferredSizeWidget{
  final double size = 20;

  const MyAppBarSearch({Key? key}) : super(key: key);

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
    Image.asset("assets/images/hb_logo.jpeg",height: 62,width: 63,),

      InkWell(
          onTap: () => Navigator.pushNamed(
              context, SearchScreen.routeName),
          child: SvgPicture.asset(
              "assets/icons/search_ic.svg",
              height: size,
              width: size)),
    ]),

    )
    ),

    ])

    );


}
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
