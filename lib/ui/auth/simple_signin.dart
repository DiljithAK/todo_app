import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/providers/simple_signin_provider.dart';
import 'package:todo_app/ui/dashboard/dashboard.dart';
import 'package:todo_app/ui/widget/custom_input_field.dart';

class SimpleSignin extends StatelessWidget {
  const SimpleSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SimpleSigninProvider>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors().linkWater,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Form(
                  key: value.simpleSigninFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomInputField(
                        controller: value.usernameController,
                        hintText: 'Full Name',
                        keyboardType: TextInputType.name,
                        fieldValidator: (p0) {
                          if (p0 == null || p0 == "") {
                            return "This field is required!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomInputField(
                        controller: value.ageController,
                        hintText: 'Age',
                        keyboardType: TextInputType.number,
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
                            if (value.simpleSigninFormKey.currentState!
                                .validate()) {
                              final user = await value.insertUser();
                              if (context.mounted) {
                                if (user != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Dashboard(username: user.name)));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Failed to sign up user, please try again later."),
                                  ));
                                }
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
                          child: const Text("Sign up"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
