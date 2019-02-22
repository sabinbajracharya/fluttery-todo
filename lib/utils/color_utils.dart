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

  static Map<int, Color> _colors = Map();

  static Map<int, Color> get colors {
    if (_colors.isNotEmpty) {
      return _colors;
    }

    defaultColors.forEach((color)  {
        _colors[color.value] = color;
    });
    return _colors;
  }

  static Color getColorFrom({int id}) {
    return colors.containsKey(id) ? colors[id] : defaultColors[0];
  }
}