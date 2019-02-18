import 'package:flutter/material.dart';

class ColorUtils {

  static const Map<int, MaterialColor> _colors = {
    0: Colors.blue,
    1: Colors.green,
    2: Colors.red,
    3: Colors.purple,
    4: Colors.yellow,
    5: Colors.amber,
    6: Colors.teal,
    7: Colors.indigo,
    8: Colors.pink,
  };

  static Color getColorFrom({int id}) {
    return _colors.containsKey(id) ? _colors[id] : _colors[0];
  }
}