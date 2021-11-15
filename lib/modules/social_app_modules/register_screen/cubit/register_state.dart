part of 'register_cubit.dart';

@immutable
abstract class RegisterSocialState {}

class RegisterSocialInitial extends RegisterSocialState {}

class RegisterSocialLoading extends RegisterSocialState {}

class RegisterSocialSuccess extends RegisterSocialState {}

class RegisterSocialError extends RegisterSocialState {
  final String error;
  RegisterSocialError(this.error);
}

//=========for add user data to firestore=======
class CreateAccountSocialSuccess extends RegisterSocialState {
  final SocialUserModel model;

  CreateAccountSocialSuccess(this.model);
}

class CreateAccountSocialError extends RegisterSocialState {
  final String error;
  CreateAccountSocialError(this.error);
}

//========for change password visibilty========
class RegisterChangePasswordVisbiltySocial extends RegisterSocialState {}
