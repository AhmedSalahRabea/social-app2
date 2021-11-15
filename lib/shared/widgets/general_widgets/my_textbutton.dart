// ignore_for_file: override_on_non_overriding_member, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  final double fontSize;
  const MyTextButton(
      {required this.text, required this.onpressed, this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
