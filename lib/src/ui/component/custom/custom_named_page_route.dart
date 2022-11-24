import 'package:flutter/material.dart';

class CustomNamedPageTransition extends PageRouteBuilder {
  CustomNamedPageTransition(GlobalKey materialAppKey, String routeName,
      {Object? arguments})
      : super(
            settings: RouteSettings(arguments: arguments, name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              assert(materialAppKey.currentWidget != null);
              assert(materialAppKey.currentWidget is MaterialApp);
              var mtapp = materialAppKey.currentWidget as MaterialApp;
              var routes = mtapp.routes;
              assert(routes!.containsKey(routeName));
              return routes![routeName]!(context);
            },
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(opacity: animation, child: child),
            transitionDuration: Duration(seconds: 1));
}
