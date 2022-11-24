import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_bloc.dart';
import 'package:hand_bill/src/blocs/auth/auth_event.dart';
import 'package:hand_bill/src/blocs/auth/auth_state.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/data/model/local/route_argument.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/component/widgets.dart';
import 'package:hand_bill/src/ui/screens/navigation_package/navigation_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = "/VerificationScreen";
  RouteArgument? routeArgument;

  VerificationScreen({this.routeArgument});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  bool loading = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _email;

  @override
  void initState() {
    _email = widget.routeArgument!.param;
    // _email = "himahamed999@gmail.com";
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _onReSendButtonPressed() {
      BlocProvider.of<AuthBloc>(context)
          .add(ForgetPasswordEvent(email: _email));
    }

    _onVerifyButtonPressed() {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<AuthBloc>(context)
            .add(CheckVerificationCodeEvent(code: currentText));
        formKey.currentState!.validate();
      }
      // conditions for validating
      // if (currentText.length != 6 ) {
      //   errorController!
      //       .add(ErrorAnimationType.shake); // Triggering error shake animation
      //   setState(() => hasError = true);
      // } else {
      //   setState(
      //     () {
      //       hasError = false;
      //       snackBar("Code Verified!!");
      //     },
      //   );
      // }
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
                displaySnackBar(
                    scaffoldKey: _scaffoldKey, title: state.error ?? "error");
                setState(() => loading = false);
              }
              if (state is ForgetPasswordSuccess) {
                displaySnackBar(
                    scaffoldKey: _scaffoldKey, title: state.message!);
                setState(() => loading = false);
              }
              if (state is CheckVerificationCodeSuccess) {
                Navigator.pushNamedAndRemoveUntil(context,
                    NavigationScreen.routeName, ModalRoute.withName('/'));
              }
            },
            child: Container(
                height: size.height,
                width: size.width,
                child: ListView(children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    height: size.height * 0.25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Transform.scale(
                            scale: 0.5, child: Image.asset(logo))),
                  ),
                  SizedBox(height: 8),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Email Verification',
                          style: TextStyle(
                              color: textDarkColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                          textAlign: TextAlign.center)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: RichText(
                      text: TextSpan(
                          text: "Enter the code sent to \n",
                          children: [
                            TextSpan(
                                text: "$_email",
                                style: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          textStyle: TextStyle(color: textDarkColor),
                          // obscureText: true,
                          // obscuringCharacter: '*',
                          // obscuringWidget: FlutterLogo(size: 24),
                          // blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          // validator: (v) {
                          //   if (v!.length < 3) {
                          //     return "I'm from validator";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Color(0xfff5f5f5),
                              disabledColor: Color(0xffeeeeee),
                              inactiveColor: mainColorLite,
                              selectedFillColor: mainColorLite,
                              activeColor: mainColorLite),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't receive the code? ",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                      TextButton(
                          onPressed: () {
                            _onReSendButtonPressed();
                          },
                          child: Text(
                            "RESEND",
                            style: TextStyle(
                                color: mainColorLite,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomButton(
                      title: "VERIFY",
                      radius: 900,
                      width: size.width * 0.7,
                      onPress: () {
                        _onVerifyButtonPressed();
                      },
                    )
                  ]),
                  loading == false
                      ? SizedBox()
                      : Container(
                          height: 100,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(height: 16),
                                CircularProgressIndicator(
                                    color: Theme.of(context).accentColor,
                                    strokeWidth: 2)
                              ])),
                  // SizedBox(height: 16),
                ]))));
  }
}
