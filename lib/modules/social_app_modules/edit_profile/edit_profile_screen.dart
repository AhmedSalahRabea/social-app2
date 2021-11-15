// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_app/shared/widgets/general_widgets/my_appbar.dart';
import 'package:social_app/shared/widgets/general_widgets/my_default_button.dart';
import 'package:social_app/shared/widgets/general_widgets/my_text_field.dart';
import 'package:social_app/shared/widgets/general_widgets/my_textbutton.dart';
import 'package:social_app/social_layout/cubit/social_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController name_controller = TextEditingController();
  TextEditingController bio_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        SocialCubit cubit = SocialCubit.get(context);
        name_controller.text = userModel!.name;
        bio_controller.text = userModel.bio;
        phone_controller.text = userModel.phone;
        return Scaffold(
          appBar: MyAppBar(
            title: 'Edit Your Profile',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: MyTextButton(
                  text: 'Update',
                  onpressed: () {
                    cubit.updateUserData(
                      name: name_controller.text,
                      phone: phone_controller.text,
                      bio: bio_controller.text,
                      //   context: context,
                    );
                  },
                  fontSize: 17,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialLoadingUserDataUpload)
                    LinearProgressIndicator(),
                  if (state is SocialLoadingUserDataUpload)
                    SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      topLeft: Radius.circular(4)),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: cubit.coverImage == null
                                        ? CachedNetworkImageProvider(
                                            userModel.coverImage!,
                                          )
                                        : FileImage(cubit.coverImage!)
                                            as ImageProvider<Object>,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.pickCoverImage(
                                      context, ImageSource.gallery);
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 53,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage == null
                                    ? CachedNetworkImageProvider(
                                        userModel.image!)
                                    : FileImage(profileImage)
                                        as ImageProvider<Object>,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.pickProfileImage(
                                  context,
                                  ImageSource.gallery,
                                );
                              },
                              icon: CircleAvatar(
                                radius: 15,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                MyDefaultButton(
                                  text: 'Upload Profile',
                                  function: () {
                                    cubit.uploadProfileImage(
                                      context,
                                      name: name_controller.text,
                                      phone: phone_controller.text,
                                      bio: bio_controller.text,
                                    );
                                  },
                                ),
                                if (state is SocialLoadingUserDataUpload)
                                  SizedBox(height: 5),
                                if (state is SocialLoadingUserDataUpload)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (cubit.coverImage != null) SizedBox(width: 20),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                MyDefaultButton(
                                  text: 'Upload Cover',
                                  function: () {
                                    cubit.uploadCoverImage(
                                      context,
                                      name: name_controller.text,
                                      phone: phone_controller.text,
                                      bio: bio_controller.text,
                                    );
                                  },
                                ),
                                if (state is SocialLoadingUserDataUpload)
                                  SizedBox(height: 5),
                                if (state is SocialLoadingUserDataUpload)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    controller: name_controller,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'name should not be empty ..';
                      }
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    controller: phone_controller,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'phone should not be empty ..';
                      }
                    },
                    label: 'Phone Number',
                    prefix: Icons.call,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    controller: bio_controller,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'bio should not be empty ..';
                      }
                    },
                    label: 'Bio',
                    prefix: Icons.info_outlined,
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
