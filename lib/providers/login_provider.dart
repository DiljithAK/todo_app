import 'package:flutter/material.dart';
import 'package:todo_app/models/request_models/login_request_model.dart';
import 'package:todo_app/services/auth_services/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final loginKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  final RegExp emailRegEx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  Future<Map<String, dynamic>> login() async {
    final loginData = LoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );
    final response = await AuthService.loginUser(loginData);
    return response;
  }

  passwordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
