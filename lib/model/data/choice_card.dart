import 'package:flutter/material.dart';

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Privacy Policy', icon: Icons.vpn_key),
];
