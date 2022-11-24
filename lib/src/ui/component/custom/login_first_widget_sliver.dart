import 'package:flutter/material.dart';
import 'package:hand_bill/src/ui/component/custom/custom_button.dart';
import 'package:hand_bill/src/ui/screens/auth/auth_screen.dart';

class CenterWidgetListSliver extends StatelessWidget {
  final String label;
  final bool showLoginBtn;
  final double paddingHor;

  CenterWidgetListSliver(
      {required this.label, this.showLoginBtn = false, this.paddingHor = 0});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center),
                SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  showLoginBtn
                      ? CustomButton(
                          title: "sign in",
                          verticalPadding: 16,
                          horizontalPadding: 40,
                          radius: 90,
                          onPress: () {
                            Navigator.pushReplacementNamed(
                                context, AuthScreen.routeName);
                          })
                      : SizedBox()
                ])
              ],
            )));
  }
}
