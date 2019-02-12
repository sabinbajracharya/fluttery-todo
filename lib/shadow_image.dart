import 'package:flutter/material.dart';

class ShadowImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 25.0, // has the effect of softening the shadow
            spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              8.0, // vertical, move down 10
            ),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          'https://content-static.upwork.com/uploads/2014/10/01073427/profilephoto1.jpg',
          height: 52,
          width: 52,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
