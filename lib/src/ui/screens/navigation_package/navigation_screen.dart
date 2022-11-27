import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/ui/component/items/To%20Be%20Seller.dart';
import 'package:hand_bill/src/ui/screens/account_package/account_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/categories/categories_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/home/componenet/my_app_bar.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/home/home_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/search/appBar2.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/services_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/ui/screens/services_package/shipping/shipping_main_screen.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = "/navigationScreen";

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  PageController? _pageController;
  late List<Widget> _pages;
  double xOffset = 0, yOffset = 0, scaleFactor = 1;
  bool isDrawerOpen = false, isDragging = false;

  late int _selectedPageIndex;

  // User? _user;
  // late NotificationsBloc _notificationsBloc;

  void openDrawer() => setState(() {
        xOffset = 230;
        yOffset = 150;
        scaleFactor = 0.6;
        isDrawerOpen = true;
      });

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });

  @override
  void initState() {
    closeDrawer();
    _selectedPageIndex = 0;
    // _selectedPageIndex = 3;
    _pages = [
      HomeScreen(),
      CategoriesScreen(),
      ShippingMainScreen(),
      // ServicesScreen(),
      // ExploreScreen(),
      AccountScreen()
    ];
    _pageController = PageController(initialPage: _selectedPageIndex);
    // _notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    // fetch();
    super.initState();
  }

  fetch() {
    // _user = BlocProvider.of<GlobalBloc>(context).user;
    // print("user nav ${_user?.name}");
    // if (_user != null) {
    //   _notificationsBloc..add(NotificationsFetchEvent());
    //   _cartBloc..add(FetchCartEvent());
    // }
  }

  int? max = -1;

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  Color? activeColor, inactiveColor, textColor;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {

    activeColor = mainColor;
    inactiveColor = Color(0xffABABAB);
    textColor = mainColor;
    textAlign = ui.TextAlign.center;
    return Scaffold(
        appBar: _selectedPageIndex == 0
            ? AppBar(
          elevation: 0,
          toolbarHeight: 33,
                backgroundColor: Colors.white,
                title:
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Image.asset("assets/images/hb_logo.jpeg", height: 31),
                      )),


              )
            : _selectedPageIndex == 1
                ? MyAppBarSearch()
                : _selectedPageIndex == 2
                    ? MyAppBar()
                    : AppBar(
          elevation: 0,
          toolbarHeight: 33,
          backgroundColor: Colors.white,
          title:
          Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Image.asset("assets/images/hb_logo.jpeg", height: 31),
              )),

        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: double.infinity, height: 2, color: Color(0xfff5f5f5)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: Color(0xffffffff),
                child: GNav(
                    backgroundColor: Color(0xffffffff),
                    rippleColor: mainColorLite,
                    hoverColor: mainColorLite,
                    haptic: true,
                    tabBorderRadius: 90,
                    gap: 8,
                    color: Colors.grey[500],
                    // activeColor: Colors.grey[700],
                    activeColor: mainColorLite,
                    // tabBackgroundColor: Color(0xffffffff),
                    // tabActiveBorder: Border.all(color: Colors.grey[700]!),
                    tabActiveBorder: Border.all(color: mainColorLite),
                    // Color(0xff434343),
                    iconSize: 30.w,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                     // tabMargin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    selectedIndex: _selectedPageIndex,
                    tabs: [
                      GButton(
                          icon: Icons.home_filled,
                          text: "titleHome".tr()),
                      GButton(
                          icon: Icons.widgets_outlined,
                          text: "all_market".tr()),
                      GButton(
                          icon: Icons.settings_applications,
                          text: "services".tr()),
                      // GButton(
                      //     icon: Icons.explore_outlined,
                      //     text: translate("app_bar.services")),
                      // GButton(icon: Icons.video_call_outlined, text: 'Explore'),
                      GButton(
                          icon: Icons.person_outline,
                          text: "account".tr()),
                    ],
                    onTabChange: (index) {
                      setState(() => _selectedPageIndex = index);
                      _pageController!.jumpToPage(index);
                    }))
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<GlobalBloc, GlobalState>(
              listener: (BuildContext context, state) {},
            )
            // BlocListener<NotificationsBloc, NotificationsState>(
            //     listener: (context, state) {
            //   if (state is NotificationsSuccessState) {
            //     setState(() {
            //       _notificationCount = state.items!.length;
            //     });
            //   }
            //   if (state is NotificationsErrorState) {
            //     Fluttertoast.showToast(msg: state.error!);
            //   }
            // }),
          ],
          child: PageView.custom(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              childrenDelegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return KeepAlive(
                    widget: _pages[index], key: ValueKey<String>(""));
              }, childCount: _pages.length)),
        ));
  }
}

class KeepAlive extends StatefulWidget {
  const KeepAlive({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  _KeepAliveState createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.widget;
  }
}

