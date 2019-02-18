import 'package:flutter/material.dart';
class ScaleRoute extends PageRouteBuilder {
  final Widget widget;
  ScaleRoute({this.widget})
    : super(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return widget;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return new ScaleTransition(
            scale: new Tween<double>(
              begin: 0.6,
              end: 1.0,
            ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(
                    0.00,
                    1.00,
                    curve: Curves.linear,
                  ),
                ),
              ),
            child: child,
           );
         }
      );
}

// Ref: https://medium.com/@agungsurya/create-custom-router-transition-in-flutter-using-pageroutebuilder-73a1a9c4a171
// Ref: Tween: https://flutterbyexample.com/step-one-tweening/