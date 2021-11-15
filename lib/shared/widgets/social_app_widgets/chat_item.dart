// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/social_app_models/social_user_model.dart';
import 'package:social_app/modules/social_app_modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatItem extends StatelessWidget {
  final SocialUserModel model;

  ChatItem({required this.model});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context: context, screen: ChatDetailsScreen(userModel: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(
                model.image!,
              ),
            ),
            SizedBox(width: 15),
            Text(
              model.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
