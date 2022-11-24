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
import 'package:hand_bill/src/ui/component/custom/regular_app_bar.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/auth/login_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/rest_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = "/forgetPasswordScreen";

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  double marginVer = 24;
  bool _autoValidate = false, loading = false;

  @override
  void initState() {
    // _emailController.text = "himahamed999@gmail.com";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onSendButtonPressed() {
      BlocProvider.of<AuthBloc>(context)
          .add(ForgetPasswordEvent(email: _emailController.text.trim()));
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // appBar: RegularAppBar(label: "Forget password"),
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthLoading) {
              setState(() => loading = true);
            }
            if (state is AuthFailure) {
              displaySnackBar(
                  scaffoldKey: _scaffoldKey, title: state.error ?? "error");
              setState(() => loading = false);
            }
            if (state is ForgetPasswordSuccess) {
              Fluttertoast.showToast(msg: state.message!);
              Navigator.pushReplacementNamed(
                  context, RestPasswordScreen.routeName);
            }
          },
          child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
            SliverFillRemaining(
                child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                    width: double.infinity,
                    height: size.height * 0.4,
                    child:
                        Transform.scale(scale: 0.5, child: Image.asset(logo))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(children: [
                                Expanded(
                                    child: Text(
                                        "Please enter email to reset password",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: textDarkColor)))
                              ])),
                          SizedBox(height: marginVer),
                          Form(
                              key: _key,
                              child: CustomTextFormField(
                                  hintText: "email",
                                  icon: Icons.alternate_email,
                                  controller: _emailController,
                                  validator: (input) {
                                    if (!input.toString().contains('@')) {
                                      return "enter valid email";
                                    }
                                    return null;
                                  })),
                          SizedBox(height: marginVer * 2),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                    title: "Send",
                                    width: size.width * 0.7,
                                    radius: 900,
                                    onPress: () {
                                      if (_key.currentState!.validate()) {
                                        _onSendButtonPressed();
                                      }
                                    }),
                              ]),
                          SizedBox(height: marginVer),
                        ])),
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
              ],
            ))
          ])),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.routeName),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Color(0xfff5f5f5)))),
                child: Center(
                    child: Text("I remember my password return to login",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)))))
      ]),
    );
  }
}
