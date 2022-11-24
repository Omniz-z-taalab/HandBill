import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/auth/auth_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_event.dart';
import 'package:hand_bill/src/blocs/auth/auth_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/custom/custom_text_filed.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/auth/forget_password_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_bill/src/ui/screens/auth/register_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/verification_screen.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false, loading = false;
  double marginVer = 24;
  AuthBloc? _authBloc;
  @override
  void didChangeDependencies() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      _authBloc!..add(LoginEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()));
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(
            listener: (BuildContext context, state) {
              if (state is AuthLoading) {
                setState(() => loading = true);
              }
              if (state is AuthFailure) {
                Fluttertoast.showToast(
                    msg: state.error ?? '',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                setState(() => loading = false);
              }
              if (state is LoginSuccess) {
                if (state.user!.isVerified == "1") {
                  Fluttertoast.showToast(
                      msg: state.message ?? '',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  setState(() => loading = false);

                  Navigator.pushNamedAndRemoveUntil(context,
                      NavigationScreen.routeName, ModalRoute.withName('/'));
                } else {
                  Navigator.pushReplacementNamed(
                      context, VerificationScreen.routeName,
                      arguments: RouteArgument(param: state.user!.email));
                }
              }
            },
            child: SingleChildScrollView(
              child: Container(
                  height: size.height,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: double.infinity,
                            height: size.height * 0.35,
                            child: Transform.scale(
                                scale: 0.5, child: Image.asset(logo))),
                        Form(
                            key: _key,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                            child: CustomTextFormField(
                                                hintText: "login.email".tr(),
                                                icon: Icons.alternate_email,
                                                controller: _emailController,
                                                isEmail: true,
                                                validator: (input) {
                                                  if (!input
                                                      .toString()
                                                      .contains('@')) {
                                                    return  "valid_email".tr();
                                                  }
                                                  return null;
                                                }))
                                      ]),
                                      SizedBox(height: marginVer),
                                      Row(children: [
                                        Expanded(
                                            child: CustomTextFormField(
                                                hintText:  "password".tr(),
                                                icon:
                                                    Icons.lock_outline_rounded,
                                                controller: _passwordController,
                                                isPassword: true,
                                                validator: (input) =>
                                                    input.toString().isEmpty
                                                        ? "enter_password".tr()
                                                        : null))
                                      ]),
                                      SizedBox(height: marginVer * 2),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomButton(
                                                title: "login".tr(),
                                                width: size.width * 0.7,
                                                radius: 900,
                                                onPress: () {
                                                  if (_key.currentState!
                                                      .validate()) {
                                                    _onLoginButtonPressed();
                                                  }
                                                }),
                                          ]),
                                      SizedBox(height: marginVer),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () => Navigator
                                                    .pushReplacementNamed(
                                                        context,
                                                        ForgetPasswordScreen
                                                            .routeName),
                                                child: Text("forget_pass".tr(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: textDarkColor)))
                                          ]),
                                    ]))),
                        loading == false
                            ? SizedBox()
                            : Container(
                                height: 100,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(height: marginVer),
                                      CircularProgressIndicator(
                                          color: Theme.of(context).accentColor,
                                          strokeWidth: 2)
                                    ])),
                        InkWell(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName),
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xfffafafa),
                                    border: Border.symmetric(
                                        horizontal: BorderSide(
                                            color: Color(0xfff5f5f5)))),
                                child: Center(
                                    child: Text("dont_have_anaccount".tr(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black))))),
                        SizedBox(
                          height: 10.h,
                        ),
                      ])),
            )));
  }
}
