import 'dart:developer';
import 'dart:html';

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

  List<Map<String, dynamic>> login() {
    final loginData = LoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );
    final response = AuthService.loginUser(loginData);
    inspect(response);
    return [
      {"status": 1, "Message": "Login successful"}
    ];
  }

  passwordVisibility() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
