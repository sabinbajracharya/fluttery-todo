import 'package:flutter/material.dart';

class TodoBadge extends StatelessWidget {
  final int codePoint;
  final Color color;
  final String id;
  final double size;
  final Color outlineColor;

  TodoBadge({
    @required this.codePoint,
    @required this.color,
    @required this.id,
    Color outlineColor,
    this.size,
  }) : this.outlineColor = outlineColor ?? Colors.grey.shade200;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: outlineColor,
          ),
        ),
        child: Icon(
          IconData(
            codePoint,
            fontFamily: 'MaterialIcons',
          ),
          color: color,
          size: size,
        ),
      ),
    );
  }
}
