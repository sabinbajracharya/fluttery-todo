import 'package:flutter/material.dart';

class ColorUtils {

  static Map<int, Color> _colors = {
    Colors.blue.value: Colors.blue,
    Colors.green.value: Colors.green,
    Colors.red.value: Colors.red,
    Colors.purple.value: Colors.purple,
    Colors.yellow.value: Colors.yellow,
    Colors.amber.value: Colors.amber,
    Colors.teal.value: Colors.teal,
    Colors.indigo.value: Colors.indigo,
    Colors.pink.value: Colors.pink,
    Colors.black.value: Colors.black,
  };

  static Color getColorFrom({int id}) {
    return _colors.containsKey(id) ? _colors[id] : _colors[0];
  }
}