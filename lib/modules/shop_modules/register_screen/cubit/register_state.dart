part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final LoginModel loginModel;

  RegisterSuccess(this.loginModel);
}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}

//========for change password visibilty========
class RegisterChangePasswordVisbilty extends RegisterState {}
