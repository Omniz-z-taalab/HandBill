import 'package:flutter/material.dart';
import 'package:hand_bill/src/common/constns.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/screens/auth/auth_screen.dart';
import 'package:hand_bill/src/ui/screens/auth/login_screen.dart';

class LoginFirstAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("please_login_first_to_continue",
          style: Theme.of(context).textTheme.headline1),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                          "you_must_create_a_new_account_or_log_in_if_you_have_an_account",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.start))
                ],
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                  title: "sign_in",
                  radius: 90,
                  onPress: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                        context, AuthScreen.routeName);
                  }))
        ],
      ),
      actions: <Widget>[
        TextButton(
            child: new Text("cancel", style: TextStyle(color: textLiteColor)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
