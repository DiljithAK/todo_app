import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/constants/colors.dart';
import 'package:todo_app/app/constants/scales.dart';
import 'package:todo_app/app/core/providers/simple_signin_provider.dart';
import 'package:todo_app/app/screens/auth/theme_selector.dart';
import 'package:todo_app/app/screens/widget/custom_input_field.dart';
import 'package:todo_app/app/screens/widget/submit_button.dart';

class SimpleSignin extends StatelessWidget {
  const SimpleSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SimpleSigninProvider>(
        builder: (context, value, child) => Container(
          padding: AppScale().sPadding20,
          child: Center(
            child: Container(
              padding: AppScale().sPadding20,
              decoration: BoxDecoration(
                color: AppColors().linkWater,
                borderRadius: AppScale().bRadius10,
              ),
              child: Form(
                key: value.simpleSigninFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomInputField(
                      controller: value.usernameController,
                      textCapitalization: TextCapitalization.words,
                      hintText: 'Full Name',
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
                    SubmitButton(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 45,
                      onBtnPress: () async {
                        if (value.simpleSigninFormKey.currentState!
                            .validate()) {
                          final user = await value.insertUser();
                          if (context.mounted) {
                            if (user ?? false) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ThemeSelector()));
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
                      btnText: "Sign up",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
