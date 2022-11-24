import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hand_bill/src/blocs/auth/auth_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_event.dart';
import 'package:hand_bill/src/blocs/auth/auth_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/custom/custom_text_filed.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/auth/login_screen.dart';

class RestPasswordScreen extends StatefulWidget {
  static const routeName = "/restPasswordScreen";
  // RouteArgument? routeArgument;
  //
  // RestPasswordScreen({this.routeArgument});

  @override
  _RestPasswordScreenState createState() => _RestPasswordScreenState();
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _codeController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  double marginVer = 24;
  bool  loading = false;

  @override
  void initState() {
    // _codeController.text = "";
    // _newPasswordController.text = "1234567";
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onSubmitButtonPressed() {
      BlocProvider.of<AuthBloc>(context).add(RestPasswordEvent(
          code: _codeController.text.trim(),
          newPassword: _newPasswordController.text.trim()));
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // appBar: RegularAppBar(label: "Rest password"),
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
            if (state is RestPasswordSuccess) {
              Fluttertoast.showToast(msg: state.message!);
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, ModalRoute.withName('/'));
            }
          },
          child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
            SliverFillRemaining(
                child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                    width: double.infinity,
                    height: size.height * 0.35,
                    child:
                        Transform.scale(scale: 0.5, child: Image.asset(logo))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                        key: _key,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Row(children: [
                                    Expanded(
                                        child: Text(
                                            "please enter the code we sent to your email",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: textDarkColor)))
                                  ])),
                              SizedBox(height: marginVer),
                              CustomTextFormField(
                                  hintText: "enter code",
                                  icon: Icons.mail_outline,
                                  controller: _codeController,
                                  validator: (input) {
                                    if (input.toString().length < 6) {
                                      return "enter valid code";
                                    }
                                    return null;
                                  }),
                              SizedBox(height: marginVer),
                              CustomTextFormField(
                                  hintText: "new password",
                                  icon: Icons.lock_outline,
                                  controller: _newPasswordController,
                                  validator: (input) {
                                    if (input.toString().length < 6) {
                                      return "password is to short";
                                    }
                                    return null;
                                  }),
                              SizedBox(height: marginVer * 2),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                        title: "Submit",
                                        width: size.width * 0.7,
                                        radius: 900,
                                        onPress: () {
                                          if (_key.currentState!.validate()) {
                                            _onSubmitButtonPressed();
                                          }
                                        }),
                                  ]),
                              SizedBox(height: marginVer),
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
