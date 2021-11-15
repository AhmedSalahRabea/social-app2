part of 'login_cubit.dart';

@immutable
abstract class LoginSocialState {}

class LoginSocialInitial extends LoginSocialState {}

class LoginSocialLoading extends LoginSocialState {}

class LoginSocialSuccess extends LoginSocialState {
  final String uId;

  LoginSocialSuccess(this.uId);
}

class LoginSocialError extends LoginSocialState {
  final String error;
  LoginSocialError(this.error);
}

//========for change password visibilty========
class LoginChangePasswordVisbiltySocial extends LoginSocialState {}
