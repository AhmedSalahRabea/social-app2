// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, dead_code, unused_element, must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app_models/message_model.dart';
import 'package:social_app/models/social_app_models/social_user_model.dart';
import 'package:social_app/social_layout/cubit/social_cubit.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel userModel;

  ChatDetailsScreen({required this.userModel});

  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(recieverId: userModel.uId!);
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                      userModel.image!,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(userModel.name),
                ],
              ),
              titleSpacing: 0,
            ),
            body: BuildCondition(
                condition: cubit.messages.isNotEmpty,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message =
                                    SocialCubit.get(context).messages[index];
                                if (SocialCubit.get(context).userModel!.uId ==
                                    message.senderId) {
                                  return buildMessage(context, message);
                                } else {
                                  return buildMyMessage(context, message);
                                }
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15),
                              itemCount: cubit.messages.length,
                            ),
                          ),
                          // Spacer(),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type ypur message here',
                                      contentPadding: EdgeInsets.only(left: 10),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  color: Colors.deepOrange,
                                  child: MaterialButton(
                                    onPressed: () {
                                      cubit.sendMessage(
                                        recieverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                      messageController.clear();
                                    },
                                    minWidth: 1,
                                    child: Icon(
                                      Icons.send,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
          );
        },
      );
    });
  }

  Widget buildMessage(context, MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: Text(
          message.text!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  Widget buildMyMessage(context, MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: Text(
          message.text!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
