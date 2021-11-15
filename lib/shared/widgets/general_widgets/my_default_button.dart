// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class MyDefaultButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final String text;
  final VoidCallback function;
  final double fontSize;
  final Color textColor;
  MyDefaultButton({
    this.width = double.infinity,
    this.backgroundColor = Colors.deepOrange,
    this.fontSize = 15,
    this.textColor = Colors.white,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      //padding: EdgeInsets.symmetric(vertical: 40),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: fontSize,
                color: textColor,
              ),
        ),
        onPressed: function,
        color: backgroundColor,
        elevation: 10,
        // color: Colors.blue,
      ),
    );
  }
}
