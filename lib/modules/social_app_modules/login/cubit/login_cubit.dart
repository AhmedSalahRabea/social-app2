// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/shared/components/components.dart';

part 'login_state.dart';

class LoginSocialCubit extends Cubit<LoginSocialState> {
  LoginSocialCubit() : super(LoginSocialInitial());
  static LoginSocialCubit get(context) => BlocProvider.of(context);
  //=========this method uses when user press on login button to login==========

  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginSocialLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
     // SocialCubit.get(context).getUserData();
      print(userCredential.user!.email);
      emit(LoginSocialSuccess(userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        buildToast(
            message: 'No user found for that email.',
            context: context,
            color: Colors.red);
      } else if (e.code == 'wrong-password') {
        buildToast(
            message: 'Wrong password provided for that user.',
            context: context,
            color: Colors.red);
      }
      emit(LoginSocialError(e.toString()));
    } catch (e) {
      print(e.toString());
      buildToast(
          message: 'something went wrong', context: context, color: Colors.red);
      emit(LoginSocialError(e.toString()));
    }
  }

  //======to change password icon in form text field ========
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  //the icon will change based on isPassword variable value...
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisbiltySocial());
  }
}
