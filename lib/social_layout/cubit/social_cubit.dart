// ignore_for_file: avoid_print, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/social_app_models/message_model.dart';
import 'package:social_app/models/social_app_models/post_model.dart';
import 'package:social_app/models/social_app_models/social_user_model.dart';
import 'package:social_app/modules/social_app_modules/chats/chat_screen.dart';
import 'package:social_app/modules/social_app_modules/feeds/feeds.dart';
import 'package:social_app/modules/social_app_modules/login/social_login_screen.dart';
import 'package:social_app/modules/social_app_modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/social_app_modules/settings/settings_screen.dart';
import 'package:social_app/modules/social_app_modules/users/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/network/local/cache_helper.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
  static SocialCubit get(context) => BlocProvider.of(context);

//=======method to get user data from firestore=====
  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialLoadingUserData());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetSuccessUserData());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetErrorUserData(error.toString()));
    });
  }

//==========get profile image picker==========
  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> pickProfileImage(
      BuildContext context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessfully());
    } else {
      buildToast(message: 'No Image Selected', context: context);
      emit(SocialErrorProfileImagePicked());
    }
  }

  //==========get coverimage picker==========
  File? coverImage;
  // i will use the same imagepicker above

  Future<void> pickCoverImage(BuildContext context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessfully());
    } else {
      buildToast(message: 'No Image Selected', context: context);
      emit(SocialErrorCoverImagePicked());
    }
  }

  //====upload profile image to firebase storage

  void uploadProfileImage(
    BuildContext context, {
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialLoadingUserDataUpload());
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    storage
        .ref('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialProfileImageUploadedSuccessfully());
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialErrorProfilemageUploaded());
        print(error.toString());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorProfilemageUploaded());
    });
  }

  //====upload cover image to firebase storage

  void uploadCoverImage(
    BuildContext context, {
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialLoadingUserDataUpload());
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    storage
        .ref('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialCoverImageUploadedSuccessfully());
        print(value);
        //to do => upload this string to firestore
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialErrorCoverImageUploaded());
        print(error.toString());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialErrorCoverImageUploaded());
    });
  }

  //========updata user data==========
  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  //   required BuildContext context,
  // }) {
  //   emit(SocialLoadingUserDataUpload());
  //   if (coverImage != null) {
  //     uploadCoverImage(context);
  //   } else if (profileImage != null) {
  //     uploadProfileImage(context);
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUserData(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      coverImage: cover ?? userModel!.coverImage,
      email: userModel!.email,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserDataUploadedError());
    });
  }

  //==========get post image picker==========
  File? postImage;
  // i will use the same imagepicker above

  Future<void> pickPostImage(BuildContext context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageUploadedSuccessfully());
    } else {
      buildToast(message: 'No Image Selected', context: context);
      emit(SocialErrorPostImageUploaded());
    }
  }

  //========create new post=====
  void uploadPostImage(
    BuildContext context, {
    required String dateTime,
    required String text,
  }) {
    emit(SocialLoadingCreatePost());
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    storage
        .ref('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        //to do => upload this string to firestore
      }).catchError((error) {
        emit(SocialCreatePostError());
        print(error.toString());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostError());
    });
  }

  //===========
  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialLoadingCreatePost());

    SocialPostModel model = SocialPostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toJson())
        .then((value) {
      emit(SocialCreatePostSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostError());
    });
  }

//======to remove post image when tap close button=====
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImage());
  }

  //=======method to get posts data from firestore=====
  List<SocialPostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(SocialLoadingGetPosts());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      // print(value.docs);

      value.docs.forEach((document) {
        document.reference.collection('likes').get().then((value) {
          emit(SocialLikePostLoading());
          posts.add(SocialPostModel.fromJson(document.data()));
          likes.add(value.docs.length);
          postsId.add(document.id);
        }).catchError((error) {
          print(error.toString());
        });
      });
      emit(SocialGetPostsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsError());
    });
  }

  //==========to make like on post==========
  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'liked': true,
    }).then((value) {
      emit(SocialLikePostSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLikePostError());
    });
  }

  //=====get all users========
  List<SocialUserModel> users = [];
  void getUserss() {
    emit(SocialLoadingAllUserData());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((document) {
          if (document.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(document.data()));
          }
        });
        emit(SocialGetSuccessAllUserData());
      }).catchError((error) {
        print(error.toString());
        emit(SocialErrorGetAllUserData(error.toString()));
      });
    }
  }

  //======log out =======
  void logout(context) {
    FirebaseAuth.instance.signOut().then((value) {
      users = [];
      profileImage = null;
      coverImage = null;
      uId = null;
      CacheHelper.removeDataFromSharedPrefrence(key: 'uId');
      currentIndex = 0;
      navigateAndFinish(context: context, screen: SocialLoginScreen());
      emit(SocialLogoutSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLogoutError());
    });
  }

//======= chat ===========
  void sendMessage({
    required String recieverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      recieverId: recieverId,
      dateTime: dateTime,
      text: text,
    );
    //add the message to the sender

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      emit(SocialSendMessageError());
    });

    //add the message to the reciever

    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      emit(SocialSendMessageError());
    });
  }

// ==========get messages chat ==========
  List<MessageModel> messages = [];
  void getMessages({
    required String recieverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((message) {
        messages.add(MessageModel.fromJson(message.data()));
      });
      emit(SocialGetMessageSuccess());
    });
  }

//========bottom nav bar=====
  int currentIndex = 0;
  List<String> titles = ['News Feeds', 'chats', 'Post', 'User', 'Settings'];

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    SocialUserScreen(),
    SocialSettingsScreen(),
  ];
  void changeBottomNavBar(int index) {
    if (index == 1) {
      getUserss();
    }
    if (index == 4) {
      getUserData();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialBottomNavBarChange());
    }
  }
}
