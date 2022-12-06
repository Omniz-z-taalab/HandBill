import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/profile/profile_bloc.dart';
import 'package:hand_bill/src/blocs/profile/profile_event.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/common/global.dart';
import 'package:hand_bill/src/data/model/local/drawer_model.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/ui/component/items/drawer_item_widget.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/account_package/agents/agents_screen.dart';
import 'package:hand_bill/src/ui/screens/account_package/wishlist/cubit.dart';
import 'package:hand_bill/src/ui/screens/account_package/wishlist/states.dart';
import 'package:hand_bill/src/ui/screens/account_package/wishlist/wishlist_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/auth_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/navigation_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/response/account/account_model.dart';
import '../services_package/asstes/assets_screen.dart';
import '../services_package/auctions/auctions_screen.dart';
import '../services_package/hand_made/hand_made_screen.dart';
import '../services_package/jobs/companies_jobs_screen.dart';
import '../services_package/offers/offers_screen.dart';
import '../services_package/patented/patents_screen.dart';
import '../navigation_package/search/search_service/shipping_screen.dart';
import 'edit_account_screen.dart';
import 'help/help_center_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double imgSize = 90;
  double marginTop = 8;
  User? _user;

  double icSize = 40;

  List<DrawerModel> _items = [];
  late GlobalBloc _globalBloc;
  late ProfileBloc _profileBloc;
  String _avatar = placeholder;
  String _name = "Guest";
  String _label = "login".tr();
  final _scaffoldKey = GlobalKey();
  FToast? fToast;

  @override
  void initState() {
    _globalBloc = BlocProvider.of<GlobalBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _user = _globalBloc.user;
    Timer(Duration(seconds: 2), () {
      if (_user != null) _profileBloc.add(ProfileFetchEvent(user: _user!));
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _items.clear();
    if (_user != null) {
      _name = _user!.name ?? "Guest";
      _label = "log_out".tr();
      _name = _globalBloc.user!.name!;
      if (_user!.image != null) {
        _avatar = APIData.domainLink + _user!.image!.url!;
      }
    }
    // _items.add(DrawerModel(
    //     title: "Chats",
    //     icon: "assets/icons/account/chat.svg",
    //     onTap: () {
    //       Navigator.pushNamed(context, ChatsScreen.routeName);
    //     }));
    // _items.add(DrawerModel(
    //     title: translate("profile.wishlist"),
    //     icon: "assets/icons/account/wishlist.svg",
    //     onTap: () {
    //       Navigator.of(context).pushNamed(WishListScreen.routeName);
    //     }));
    // _items.add(DrawerModel(
    //     title: translate("profile.help_center"),
    //     icon: "assets/icons/account/help.png",
    //     onTap: () {
    //       Navigator.of(context).pushNamed(HelpCenterScreen.routeName);
    //     }));
    // _items.add(DrawerModel(
    //     title: translate("profile.agents"),
    //     icon: "assets/icons/account/customer_service.svg",
    //     onTap: () => Navigator.of(context).pushNamed(AgentsScreen.routeName)));

    // _items.add(DrawerModel(
    //     title: translate("profile.be_a_seller"),
    //     icon: "assets/icons/account/asset.svg",
    //     onTap: () async {
    //       try {
    //         if (Platform.isIOS) {
    //           await canLaunch('') ? launch("") : print("can not open the link");
    //         } else {
    //           await canLaunch(
    //                   'https://play.google.com/store/apps/details?id=gyapp.hand_bill_manger')
    //               ? launch(
    //                   "https://play.google.com/store/apps/details?id=com.egyapp.hand_bill_manger")
    //               : print("can not open the link");
    //         }
    //       } catch (e) {
    //         print("\n $e");
    //       }
    //     }));
    // _items.add(DrawerModel(
    //     title: translate("profile.change_lang"),
    //     icon: "assets/icons/language.png",
    //     onTap: () async {
    //       await changeLocale(
    //           context, translate('button.ok').trim() == 'ok' ? 'ar' : 'en_US');
    //       Navigator.pushReplacementNamed(context, NavigationScreen.routeName);
    //     }));
    // _items.add(DrawerModel(
    //     title: translate("profile.about_us"),
    //     icon: "assets/icons/account/certificate.svg",
    //     onTap: () => Navigator.of(context).pushNamed(AboutUsScreen.routeName)));

    // _items.add(DrawerModel(
    //     title: _label,
    //     icon: "assets/icons/account/arrow.svg",
    //     onTap: () {
    //       BlocProvider.of<GlobalBloc>(context).user = null;
    //       storage.deleteAll();
    //       Navigator.pushReplacementNamed(context, AuthScreen.routeName);
    //     }));
    // _items.add(DrawerModel(
    //     title: translate("categories.jobs"),
    //     icon: "assets/icons/account/job_search.svg",
    //     onTap: () =>
    //         Navigator.pushNamed(context, CompaniesJobsScreen.routeName)));
    // _items.add(DrawerModel(
    //     title: translate("categories.auctions"),
    //     icon: "assets/icons/account/auction.svg",
    //     onTap: () => Navigator.pushNamed(context, AuctionsScreen.routeName)));
    // _items.add(DrawerModel(
    //     title: translate("categories.offers"),
    //     icon: "assets/icons/account/sale_tag.svg",
    //     onTap: () => Navigator.pushNamed(context, OffersScreen.routeName)));
    // _items.add(DrawerModel(
    //     title: translate("categories.assets"),
    //     icon: "assets/icons/account/asset.svg",
    //     onTap: () => Navigator.pushNamed(context, AssetsScreen.routeName)));
    // _items.add(DrawerModel(
    //     title: translate("categories.patented"),
    //     icon: "assets/icons/account/certificate.svg",
    //     onTap: () => Navigator.pushNamed(context, PatentsScreen.routeName)));
    // _items.add(DrawerModel(
    //     title: translate("categories.hand_made"),
    //     icon: "assets/icons/account/handmade.svg",
    //     onTap: () => Navigator.pushNamed(context, HandmadeScreen.routeName)));
    // _items.add(DrawerModel(
    //     title: translate("categories.shipping_customs_broker"),
    //     icon: "assets/icons/account/delivery_truck.svg",
    //     onTap: () => Navigator.pushNamed(context, ShippingScreen.routeName)));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var model;
    return BlocProvider(
      create: ((context) => AccountBloc()..getItems()),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccessStates) {
            // CommonFunctions.showToast('تم تعين مشرف', Colors.green);
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          }
          if (state is AcoountErrorStates) {
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          }

          // if (state is AddBlockListSuccessStates) {
          //   CommonFunctions.showToast('تم حظر العظو', Colors.green);
          // }
        },
        builder: (context, state) {
          model = AccountBloc.get(context).acountModel;
          return ConditionalBuilder(
            condition: AccountBloc.get(context).acountModel != null,
            builder: (context) => item(model, size),
            fallback: (context) => Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },

        // },
      ),
    );
  }
  Widget item(AcountModel model, Size size) => Scaffold(
      // backgroundColor: Color(0xffeeeeee),
      backgroundColor: Color(0xfff5f5f5),
      body: RefreshIndicator(
          onRefresh: () async {
            if (_globalBloc.user!.image != null) {
              setState(() {
                _avatar = APIData.domainLink + _globalBloc.user!.image!.url!;
                _name = _globalBloc.user!.name!;
              });
            }
          },
          child: Stack(children: [
            ListView(
                // physics: BouncingScrollPhysics(),
                children: [
                  Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                            onTap: () {
                              if (_user == null) {
                                Fluttertoast.showToast(
                                    msg:"login".tr(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );                              } else {
                                Navigator.pushNamed(
                                    context, EditAccountScreen.routeName);
                              }
                            },
                            child: Container(
                                height: size.height * 0.11,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Row(children: [
                                  AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(90)),
                                          child: CachedNetworkImage(
                                              imageUrl: _avatar,
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) =>
                                                  Transform.scale(
                                                      scale: 0.4,
                                                      child:
                                                          CircularProgressIndicator(
                                                              color:
                                                                  mainColorLite)),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  new Icon(Icons.error,
                                                      color: mainColorLite)))),
                                  SizedBox(width: 16),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        InkWell(
                                            child: Row(children: [
                                          Text(
                                             "account_info".tr(),
                                              style: TextStyle(
                                                  // fontSize: 13,
                                                  color: textLiteColor)),
                                          Icon(Icons.keyboard_arrow_right,
                                              color: iconColors, size: 18)
                                        ]))
                                      ]),
                                ]))),
                        // SizedBox(height: 8),
                        for (int i = 0; i < model.data!.length; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    model.data![i].title!.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.count(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
                                    childAspectRatio: 1 / 0.7,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    shrinkWrap: true,
                                    primary: false,
                                    children: List.generate(
                                        model.data![i].pages!.length, (index) {
                                      return DrawerItemWidget(
                                          model: model.data![i].pages![index]);
                                    })),
                              ),
                            ],
                          ),

                        // SizedBox(height: 80),
                      ])
                ])
          ])));

  // Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: GridView.count(
  //           padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
  //           childAspectRatio: 1 / 0.7,
  //           crossAxisCount: 2,
  //           crossAxisSpacing: 2,
  //           mainAxisSpacing: 2,
  //           shrinkWrap: true,
  //           primary: false,
  //           children: List.generate(model., (index) {
  //             return DrawerItemWidget(model: model[index]);
  //           })),
  //     );
}
