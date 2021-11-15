// ignore_for_file: prefer_const_constructors
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/widgets/general_widgets/my_divider.dart';
import 'package:social_app/shared/widgets/social_app_widgets/chat_item.dart';
import 'package:social_app/social_layout/cubit/social_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        
        return BuildCondition(
          condition:SocialCubit.get(context).users.isNotEmpty ,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => ChatItem(model:  SocialCubit.get(context).users[index]),
            separatorBuilder: (context, index) => MyDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
