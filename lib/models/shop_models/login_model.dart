import 'user_data.dart';

class LoginModel {
  final bool status;
  final String? message;
  final UserData? data;

  LoginModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data:
          jsonData['data'] != null ? UserData.fromJson(jsonData['data']) : null,
    );
  }
}
