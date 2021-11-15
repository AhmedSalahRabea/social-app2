// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final ValueChanged<String>? onsubmit;
  final ValueChanged? onchange;
  final GestureTapCallback? ontap;
  final bool isPassword;
  final FormFieldValidator validate;
  final String label;
  final IconData prefix;
  final IconData? suffix;
  final Function? suffixPressed;
  final bool isClickable;

  MyTextFormField({
    required this.controller,
    required this.type,
    required this.validate,
    required this.label,
    required this.prefix,
    this.onsubmit,
    this.onchange,
    this.ontap,
    this.isPassword = false,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onsubmit,
      onChanged: onchange,
      onTap: ontap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix),
              )
            : null,
      ),
    );
  }
}
