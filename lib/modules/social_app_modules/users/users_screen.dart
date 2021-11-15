// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SocialUserScreen extends StatelessWidget {
  const SocialUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'SocialUser Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
