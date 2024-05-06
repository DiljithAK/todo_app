import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/constants/colors.dart';
import 'package:todo_app/app/providers/login_provider.dart';
import 'package:todo_app/app/screens/dashboard/dashboard.dart';
import 'package:todo_app/app/screens/widget/custom_input_field.dart';
import 'package:todo_app/app/screens/widget/custom_password_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(builder: (context, loginProvider, child) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors().linkWater, //Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            // height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.6,
            padding: const EdgeInsets.all(15),
            child: Form(
              key: loginProvider.loginKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInputField(
                    controller: loginProvider.emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    fieldValidator: (p0) {
                      if (p0 == null || p0 == "") {
                        return "This field is required!";
                      } else {
                        final bool emailValid =
                            loginProvider.emailRegEx.hasMatch(p0);
                        if (!emailValid) return "Invalid email address!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomPasswordField(
                    controller: loginProvider.passwordController,
                    hintText: "Password",
                    isObscure: loginProvider.isObscure,
                    eyeBtnonPress: loginProvider.passwordVisibility,
                    fieldValidator: (p0) {
                      if (p0 == null || p0 == "") {
                        return "This field is required!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (loginProvider.loginKey.currentState!.validate()) {
                          BuildContext context =
                              loginProvider.loginKey.currentContext!;
                          final login = await loginProvider.login();
                          if (login['status'] == 1) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(username: login['name']??'')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(login['message'])),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors().paleBlue,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Login"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
