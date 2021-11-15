// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/shared/widgets/general_widgets/my_appbar.dart';
import 'package:social_app/shared/widgets/general_widgets/my_textbutton.dart';
import 'package:social_app/social_layout/cubit/social_cubit.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  var post_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: MyAppBar(
            title: 'Create Post',
            actions: [
              MyTextButton(
                text: 'Post',
                onpressed: () {
                  if (cubit.postImage == null) {
                    cubit.createPost(
                      dateTime: DateTime.now().toString(),
                      text: post_controller.text,
                    );
                  } else {
                    cubit.uploadPostImage(
                      context,
                      dateTime: DateTime.now().toString(),
                      text: post_controller.text,
                    );
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialLoadingCreatePost)
                    LinearProgressIndicator(),
                  if (state is SocialLoadingCreatePost) SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: CachedNetworkImageProvider(
                          cubit.userModel!.image!,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          cubit.userModel!.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TextFormField(
                        maxLines: 10,
                        controller: post_controller,
                        decoration: InputDecoration(
                          hintText: 'What is on your mind ...',
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: 20),
                      if (cubit.postImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 350,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(cubit.postImage!),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.removePostImage();
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.close_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                cubit.pickPostImage(
                                  context,
                                  ImageSource.gallery,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                  ),
                                  SizedBox(width: 5),
                                  Text('add a photo')
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: Text('# tags'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
