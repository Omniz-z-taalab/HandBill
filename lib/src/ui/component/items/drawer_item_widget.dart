import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/drawer_model.dart';
import 'package:hand_bill/src/data/response/account/account_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_bill/src/ui/component/items/To%20Be%20Seller.dart';
import 'package:hand_bill/src/ui/screens/services_package/hand_made/my_handmade_screen.dart';
import 'package:hand_bill/src/ui/screens/services_package/patented/my_patents_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/global_bloc/global_bloc.dart';
import '../../../common/global.dart';
import '../../screens/account_package/aboutUs/aboutUsScreen.dart';
import '../../screens/account_package/agents/agents_screen.dart';
import '../../screens/account_package/help/help_center_screen.dart';
import '../../screens/account_package/wishlist/wishlist_screen.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/navigation_package/navigation_screen.dart';
import '../../screens/services_package/asstes/assets_screen.dart';
import '../../screens/services_package/auctions/auctions_screen.dart';
import '../../screens/services_package/hand_made/hand_made_screen.dart';
import '../../screens/services_package/jobs/companies_jobs_screen.dart';
import '../../screens/services_package/offers/offers_screen.dart';
import '../../screens/services_package/patented/patents_screen.dart';

class DrawerItemWidget extends StatefulWidget {
  final Pages model;

  DrawerItemWidget({required this.model});

  @override
  State<DrawerItemWidget> createState() => _DrawerItemWidgetState();
}

class _DrawerItemWidgetState extends State<DrawerItemWidget> {
  final double icSize = 32;

  String ar = 'ar';

  String en = 'en';

  @override
  Widget build(BuildContext context) {
    bool lang = true;
    return InkWell(
        onTap: () async {
          if (widget.model.title.toString() == 'To Be Seller') {
            if (Platform.isIOS) {
              await canLaunch('') ? launch("") : print("can not open the link");
            } else {
              await canLaunch(
                  'https://play.google.com/store/apps/details?id=gyapp.hand_bill_manger')
                  ? launch(
                  "https://play.google.com/store/apps/details?id=com.egyapp.hand_bill_manger")
                  : print("can not open the link");
            }
          }
          if (widget.model.title.toString() == 'كن بائعا') {
            if (Platform.isIOS) {
              await canLaunch('') ? launch("") : print("can not open the link");
            } else {
              await canLaunch(
                  'https://play.google.com/store/apps/details?id=gyapp.hand_bill_manger')
                  ? launch(
                  "https://play.google.com/store/apps/details?id=com.egyapp.hand_bill_manger")
                  : print("can not open the link");
            }
          }

          if (widget.model.title.toString() == 'Change Language') {
            if (context.locale.toString() == "en_US") {
              print('wewewewe');
              print(context.locale);
              setState(() {
                context.locale = const Locale('ar', 'EG');
              });
              await storage.write(key: "lang", value: ar);

              Phoenix.rebirth(context);
            }
            else {
              setState(() {
                context.locale = const Locale('en', 'US');
              });
              await storage.write(key: "lang", value: en);

              print(context.locale);
              Phoenix.rebirth(context);
            }
          }
          if (widget.model.title.toString() == 'تغيير اللغة') {
            if (context.locale.toString() == "en_US") {
              print(context.locale);
              setState(() {
                context.locale = const Locale('ar', 'EG');
              });
              await storage.write(key: "lang", value: ar);
              Phoenix.rebirth(context);
            }
            else {
              print(context.locale);
              setState(() {
                context.locale = const Locale('en', 'US');
              });
              await storage.write(key: "lang", value: en);
              Phoenix.rebirth(context);
            }
          }


          //   await Locale(
          //        'ok'.tr().trim() == 'ok' ? en : ar);
          //
          //     if ('Change Language' == en) {
          //       await storage.write(key: "lang", value: en);
          //     } else {
          //       await storage.write(key: "lang", value: ar);
          //     }
          //     print('babaaaaa');
          //     Phoenix.rebirth(context);
          //     // ignore: dead_code
          //
          // }
          // if (widget.model.title.toString() == 'تغيير اللغة') {
          //     print(widget.model.title!.toString());
          //
          //     await Locale(
          //          'ok'.tr().trim() == 'تأكيد' ? ar : en);
          //     if ('تغيير اللغة' == ar) {
          //         await storage.write(key: "lang", value: ar);
          //     } else {
          //     await storage.write(key: "lang", value: en);
          //     }
          //     print('babaaaaa');
          //     Phoenix.rebirth(context);
          //
          //
          //   // ignore: dead_code
          //

          if (widget.model.title.toString() == 'LogOut') {
            BlocProvider
                .of<GlobalBloc>(context)
                .user = null;
            storage.deleteAll();
            Navigator.pushReplacementNamed(context, AuthScreen.routeName);
          }
          widget.model.title.toString() == 'Help Center'
              ? Navigator.of(context).pushNamed(HelpCenterScreen.routeName)
              : widget.model.title.toString() == 'Wish List'
              ? Navigator.of(context).pushNamed(WishListScreen.routeName)
              : widget.model.title.toString() == 'Offers'
              ? Navigator.of(context).pushNamed(OffersScreen.routeName)
              : widget.model.title.toString() == 'Auctions'
              ? Navigator.of(context)
              .pushNamed(AuctionsScreen.routeName)
              : widget.model.title.toString() == 'Assets'
              ? Navigator.of(context)
              .pushNamed(AssetsScreen.routeName)
              : widget.model.title.toString() == 'Patented'
              ? Navigator.of(context)
              .pushNamed(PatentsScreen.routeName)
              : widget.model.title.toString() == 'Jobs'
              ? Navigator.of(context).pushNamed(
              CompaniesJobsScreen.routeName)
              : widget.model.title.toString() ==
              'Hand Made'
              ? Navigator.of(context).pushNamed(
              HandmadeScreen.routeName)
              : widget.model.title.toString() ==
              'Agents'
              ? Navigator.of(context).pushNamed(
              AgentsScreen.routeName)
              : widget.model.title.toString() ==
              'About Us'
              ? Navigator.of(context)
              .pushNamed(AboutUsScreen
              .routeName)
              : Container();
          if (widget.model.title.toString() == 'خروج') {
            BlocProvider
                .of<GlobalBloc>(context)
                .user = null;
            storage.deleteAll();
            Navigator.pushReplacementNamed(context, AuthScreen.routeName);
          }
          widget.model.title.toString() == "مركز المساعده"
              ? Navigator.of(context).pushNamed(HelpCenterScreen.routeName)
              : widget.model.title.toString() == 'قائمتى'
              ? Navigator.of(context).pushNamed(WishListScreen.routeName)
              : widget.model.title.toString() == 'عروض'
              ? Navigator.of(context).pushNamed(OffersScreen.routeName)
              : widget.model.title.toString() == 'مزادات'
              ? Navigator.of(context)
              .pushNamed(AuctionsScreen.routeName)
              : widget.model.title.toString() == 'مرافق'
              ? Navigator.of(context)
              .pushNamed(AssetsScreen.routeName)
              : widget.model.title.toString() == 'برائات أختراع'
              ? Navigator.of(context)
              .pushNamed(PatentsScreen.routeName)
              : widget.model.title.toString() == 'وظائف'
              ? Navigator.of(context).pushNamed(
              CompaniesJobsScreen.routeName)
              : widget.model.title.toString() ==
              'صناعات يدوية'
              ? Navigator.of(context).pushNamed(
              HandmadeScreen.routeName)
              : widget.model.title.toString() ==
              'الوكلاء'
              ? Navigator.of(context).pushNamed(
              AgentsScreen.routeName)
              : widget.model.title.toString() ==
              'من نحن'
              ? Navigator.of(context)
              .pushNamed(AboutUsScreen
              .routeName)
              : Container();
        },
        child: Card(
            elevation: 5,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.model.title.toString() == 'Help Center' ||
                          widget.model.title.toString() == 'مركز المساعدة'
                          ? Image.asset(
                        'assets/icons/account/help.png',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Wish List' ||
                          widget.model.title.toString() == 'قائمتى'
                          ? SvgPicture.asset(
                        'assets/icons/account/wishlist.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Offers' ||
                          widget.model.title.toString() == 'عروض'
                          ? SvgPicture.asset(
                        'assets/icons/account/sale_tag.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Auctions' ||
                          widget.model.title.toString() == 'مزادات'
                          ? SvgPicture.asset(
                        'assets/icons/account/auction.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Assets' ||
                          widget.model.title.toString() == 'مرافق'
                          ? SvgPicture.asset(
                        'assets/icons/account/asset.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Patented' ||
                          widget.model.title.toString() == 'برائات أختراع'
                          ? SvgPicture.asset(
                        'assets/icons/account/certificate.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Jobs' ||
                          widget.model.title.toString() == 'وظائف'

                          ? SvgPicture.asset(
                        'assets/icons/account/job_search.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Hand Made' ||
                          widget.model.title.toString() == 'صناعات يدوية'
                          ? SvgPicture.asset(
                        'assets/icons/account/handmade.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'To Be Seller' ||
                          widget.model.title.toString() == 'كن بائعا'
                          ? SvgPicture.asset(
                        'assets/icons/account/asset.svg',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : widget.model.title.toString() == 'Agents' ||
                          widget.model.title.toString() == 'الوكلاء'
                          ? SvgPicture
                          .asset(
                        'assets/icons/account/customer_service.svg',
                        // "assets/icons/account/wishlist.svg",
                        height:
                        icSize,
                        width: icSize,
                        fit: BoxFit
                            .cover,
                      )
                          : widget.model.title.toString() ==
                          'Change Language' ||
                          widget.model.title.toString() == 'تغيير اللغة'
                          ? Image.asset(
                        'assets/icons/language.png',
                        // "assets/icons/account/wishlist.svg",
                        height:
                        icSize,
                        width:
                        icSize,
                        fit: BoxFit
                            .cover,
                      )
                          : widget.model.title.toString() == 'LogOut' ||
                          widget.model.title.toString() == 'خروج'
                          ? SvgPicture
                          .asset(
                        'assets/icons/account/arrow.svg',
                        // "assets/icons/account/wishlist.svg",
                        height:
                        icSize,
                        width:
                        icSize,
                        fit: BoxFit
                            .cover,
                      )
                          : widget.model.title.toString() ==
                          'About Us' ||
                          widget.model.title.toString() == 'من نحن'
                          ? SvgPicture
                          .asset(
                        'assets/icons/us.png',
                        // "assets/icons/account/wishlist.svg",
                        height: icSize,
                        width: icSize,
                        fit: BoxFit.cover,
                      )
                          : Container(),
                      // model.icon!.endsWith(".svg")
                      //     ? SvgPicture.asset(model.icon!,
                      //         height: icSize, width: icSize)
                      //     : Image.asset(model.icon!,
                      //         height: icSize, width: icSize, fit: BoxFit.cover),
                      lang == true
                          ? Text((widget.model.title.toString()),
                          style: TextStyle(
                              color: textDarkColor,
                              fontWeight: FontWeight.bold),
                          maxLines: 2)
                          : Text((widget.model.titleAr.toString()),
                          style: TextStyle(
                              color: textDarkColor,
                              fontWeight: FontWeight.bold),
                          maxLines: 2)
                    ]))));
  }
}
