// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/social_app_models/social_user_model.dart';
import 'package:social_app/shared/components/components.dart';

part 'register_state.dart';

class RegisterSocialCubit extends Cubit<RegisterSocialState> {
  RegisterSocialCubit() : super(RegisterSocialInitial());
  static RegisterSocialCubit get(context) => BlocProvider.of(context);
  //=========this method uses when user press on signup button to register==========
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) async {
    emit(RegisterSocialLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential.user!.email);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: userCredential.user!.uid,
        context: context,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        buildToast(
            message: 'The password provided is too weak.',
            context: context,
            color: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        buildToast(
            message: 'The account already exists for that email.',
            context: context,
            color: Colors.red);
      }
      emit(RegisterSocialError(e.toString()));
    } catch (e) {
      buildToast(
        message: 'something went wrong please try again',
        context: context,
        color: Colors.red,
      );
      print(e);
      emit(RegisterSocialError(e.toString()));
    }
  }

//=======to add userData to firestore=======
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required BuildContext context,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://image.freepik.com/free-photo/young-handsome-man-listens-music-with-earphones_176420-15616.jpg',
      coverImage:
          'https://image.freepik.com/free-photo/young-handsome-man-listens-music-with-earphones_176420-15616.jpg',
      bio: 'Write your bio here ...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      buildToast(
          message: 'Register and add user successfully', context: context);
      emit(CreateAccountSocialSuccess(model));
    }).catchError((error) {
      print(error.toString());
      buildToast(message: 'added failed', context: context);

      emit(CreateAccountSocialError(error.toString()));
    });
  }

  //======to change password icon in form text field ========
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  //the icon will change based on isPassword variable value...
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisbiltySocial());
  }
}
