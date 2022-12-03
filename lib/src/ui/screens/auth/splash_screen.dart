import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/Services/bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_event.dart';
import 'package:hand_bill/src/blocs/category/category_bloc.dart';
import 'package:hand_bill/src/blocs/category/category_event.dart';
import 'package:hand_bill/src/blocs/global_bloc/global_bloc.dart';
import 'package:hand_bill/src/blocs/home/home_bloc.dart';
import 'package:hand_bill/src/blocs/profile/profile_bloc.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/navigation_screen.dart';

import '../../../blocs/Services/Event.dart';
import '../../../blocs/profile/profile_event.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<Offset>(
      begin: Offset(0.0, 0.9),
      end: Offset.zero,
    ).animate(_animationController!);
    _animationController?.forward().whenComplete(() {
      // when animation completes, put your code here
    });
  }

  HomeBloc? _homeBloc;
  GlobalBloc? _globalBloc;
  CategoryBloc? _categoryBloc;
  // ProfileBloc? _profileBloc;
  ServiceBlocData? _serviceBloc;
  AuthBloc? _authBloc;
  @override
  void didChangeDependencies() {
    //Future<User?> user =
    _serviceBloc = BlocProvider.of<ServiceBlocData>(context);
    _globalBloc = BlocProvider.of<GlobalBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    // _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _globalBloc!..add(StartAppEvent());
    _homeBloc!..add(HomeFetchSliders());
    // _profileBloc!..add((ProfileFetchDtaEvent()));

    // _homeBloc!..add(HomeFetchPopular());
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc!..add(FetchCountriesEvent());
    _homeBloc!..add(HomeFetchTopCompanies());
    _serviceBloc!..add(FetchServiceEvent());
    _categoryBloc!..add(FetchCategoriesEvent());
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => NavigationScreen()));
      // => user==null?
      //       RegisterScreen():
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Positioned(
            top: height * 0.2,
            left: width * 0.1,
            child: SlideTransition(
              position: _animation!,
              child: AnimatedContainer(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topLeft,
                duration: Duration(seconds: 0),
                child: Image(
                  height: height * 0.4 + 40,
                  width: width * 0.7 + 40,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/hb_logo.jpeg'),
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         width: width*0.6,
          //         child: TextLiquidFill(
          //           text: 'Game Station',
          //           waveColor: appColor,
          //           waveDuration: Duration(seconds: 2),
          //           boxBackgroundColor: Colors.white,
          //           textStyle: TextStyle(
          //               fontSize: width*0.07+2,
          //               fontWeight: FontWeight.bold,
          //               color: colorWhite
          //           ),
          //           boxHeight: height*0.09,
          //         ),
          //       ),
          //       SizedBox(height: height*0.03,),
          //       Container(
          //         width: width*0.6,
          //         alignment: Alignment.center,
          //         child: DefaultTextStyle(
          //           style: const TextStyle(
          //             fontSize: 16.0,
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //           ),
          //           child: AnimatedTextKit(
          //             animatedTexts: [
          //               WavyAnimatedText('Never Play Alone'),
          //             ],
          //             isRepeatingAnimation: false,
          //             onTap: () {
          //               print("Tap Event");
          //             },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }
}
