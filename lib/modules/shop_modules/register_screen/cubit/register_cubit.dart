// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/shop_models/login_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constans.dart';
import 'package:social_app/shared/network/remote/doi_helper.dart';
import 'package:social_app/shared/network/remote/end_points.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  //=========this method uses when user press on login button to login==========
  //an object from my loginModel class to use it inside the method
  late LoginModel loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) {
    emit(RegisterLoading());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      // token = loginModel.data!.token;
      print('new token from register=========$token');
      emit(RegisterSuccess(loginModel));
    }).catchError((error) {
      print(error.toString());
      buildToast(message: loginModel.message, context: context);
      emit(RegisterError(error.toString()));
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
    emit(RegisterChangePasswordVisbilty());
  }
}
