import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final Color color;

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
          colors: getColorList(color)
        ),
      ),
      curve: Curves.linear,
      child: child, duration: Duration(milliseconds: 500),
    );
  }

  List<Color> getColorList(Color color) {
    if (color is MaterialColor) {
      return [
           color[300],
           color[600],
           color[700],
           color[900],
          ];
    } else {
      return List<Color>.filled(4, color);
    }
  }
}