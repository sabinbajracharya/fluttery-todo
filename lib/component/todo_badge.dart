import 'package:flutter/material.dart';

class TodoBadge extends StatelessWidget {
  final int codePoint;
  final Color color;
  final String id;

  TodoBadge({
    @required this.codePoint,
    @required this.color,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(
          bottom: 6.0,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade100,
          ),
        ),
        child: Icon(
          IconData(
            codePoint,
            fontFamily: 'MaterialIcons',
          ),
          color: color,
        ),
      ),
    );
  }
}
