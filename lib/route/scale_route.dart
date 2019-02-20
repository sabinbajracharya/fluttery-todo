import 'package:flutter/material.dart';

// class MaterialScaleRoute extends MaterialPageRoute {
//   final Widget widget;

//   MaterialScaleRoute({this.widget})
//       : super(
//           builder: (BuildContext context) {
//             return new ScaleTransition(
//               scale: new Tween<double>(
//                 begin: 0.6,
//                 end: 1.0,
//               ).animate(
//                 CurvedAnimation(
//                   parent: animation,
//                   curve: Interval(
//                     0.00,
//                     1.00,
//                     curve: Curves.linear,
//                   ),
//                 ),
//               ),
//               child: widget,
//             );
//           },
//         );
// }

// class ScaleRoute extends PageRouteBuilder {
//   final Widget widget;
//   ScaleRoute({this.widget})
//       : super(pageBuilder: (
//           BuildContext context,
//           Animation<double> animation,
//           Animation<double> secondaryAnimation,
//         ) {
//           return widget;
//         }, transitionsBuilder: (
//           BuildContext context,
//           Animation<double> animation,
//           Animation<double> secondaryAnimation,
//           Widget child,
//         ) {

//           return new PositionedTransition(
//             // scale: new Tween<double>(
//             //   begin: 0,
//             //   end: 1,
//             // ).animate(
//             //   CurvedAnimation(
//             //     parent: animation,
//             //     curve: Interval(
//             //       0.00,
//             //       1.00,
//             //       curve: Curves.linear,
//             //     ),
//             //   ),
//             // ),
//             child: child, rect: RelativeRectTween(
//                begin: RelativeRect.fromLTRB(
//                  0, 100, 0.0, 100),
//               end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
//             ).animate(
//                 animation
//             ),
//           );
//         }, transitionDuration: Duration(milliseconds: 300));
// }

class ScaleRoute extends PageRouteBuilder {
  final Widget widget;
  final RelativeRect rect;
  ScaleRoute({@required this.widget, @required this.rect}) :
      super(pageBuilder: (BuildContext context,Animation<double> animation, Animation<double> secondaryAnimation) { return widget; },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return Stack(
            children: [
             Container(),
              PositionedTransition(
                child: child,
                rect: RelativeRectTween(
                  begin: rect,
                  end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
                ).animate(animation),
              ),
            ],
          );
        },
        transitionDuration: Duration(milliseconds: 300),
      );
}
// Ref: https://medium.com/@agungsurya/create-custom-router-transition-in-flutter-using-pageroutebuilder-73a1a9c4a171
// Ref: Tween: https://flutterbyexample.com/step-one-tweening/
