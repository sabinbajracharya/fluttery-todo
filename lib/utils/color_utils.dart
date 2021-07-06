import 'package:flutter/material.dart';

class ColorUtils {
  static const List<Color> defaultColors = [
    Colors.blueGrey,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
  ];

  static Map<int, Color> _color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  static Map<int, Color> _colors = Map();

  static Map<int, Color> get colors {
    if (_colors.isNotEmpty) {
      return _colors;
    }

    defaultColors.forEach((color) {
      _colors[color.value] = color;
    });
    return _colors;
  }

  static Color getColorFrom({required int id}) {
    return colors[id] ?? Colors.blueGrey;
  }

  static MaterialColor getMaterialColorFrom({required int id}) {
    return MaterialColor((colors[id] ?? Colors.blueGrey).value, _color);
  }
}
