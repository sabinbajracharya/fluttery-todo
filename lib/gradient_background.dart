import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final MaterialColor color;

  GradientBackground({@required this.child, @required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.3, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            color[300],
            color[600],
            color[700],
            color[900],
          ],
        ),
      ),
      curve: Curves.linear,
      child: child, duration: Duration(milliseconds: 500),
    );
  }
}