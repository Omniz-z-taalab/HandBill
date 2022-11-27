import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_event.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/screens/auth/login_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/register_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/navigation_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/authScreen";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthBloc? _authBloc;
  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc!..add(FetchCountriesEvent());
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      color: Colors.white,
      child: Column(children: [
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Transform.scale(
                  scale: 0.5, child: Image.asset("assets/images/hb_logo.jpeg"))
            ])),
        Container(
            height: size.height * 0.40,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                        title: "login.login".tr(),
                        color: mainColorLite,
                        borderColor: mainColorLite,
                        borderWidth: 1,
                        textStyle: TextStyle(color: Colors.white),
                        radius: 900,
                        onPress: () =>
                            Navigator.pushNamed(context, LoginScreen.routeName)),
                    SizedBox(height: 24),
                    CustomButton(
                        title: "signup.signup".tr(),
                        color: Colors.transparent,
                        textStyle: TextStyle(color: mainColorLite),
                        borderColor: mainColorLite,
                        radius: 900,
                        onPress: () => Navigator.pushNamed(
                            context, RegisterScreen.routeName)),
                    SizedBox(height: 16),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      InkWell(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              NavigationScreen.routeName,
                              ModalRoute.withName('/')),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Text("login.skip".tr(),
                                  style: TextStyle(
                                      fontSize: 16, color: textLiteColor))))
                    ])
                  ]),
            ))
      ]),
    ));
  }
}
