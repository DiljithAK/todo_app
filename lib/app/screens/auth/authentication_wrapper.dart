import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/providers/simple_signin_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todo_app/ui/auth/login_screen.dart';
import 'package:todo_app/app/screens/auth/simple_signin.dart';
import 'package:todo_app/app/screens/dashboard/dashboard.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SimpleSigninProvider>(builder: (context, value, child) {
      return FutureBuilder<Map<String, dynamic>>(
        future: checkLoginStatus(value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final data = snapshot.data ?? {'isLoggedIn': false, 'name': ''};
          return data['isLoggedIn']
              ? Dashboard(username: data['name'] ?? "")
              : const SimpleSignin();
          // : const LoginScreen();
        },
      );
    });
  }

  Future<Map<String, dynamic>> checkLoginStatus(
      SimpleSigninProvider provider) async {
    final user = await provider.getCurrentUser();
    if (user != null) {
      return {'isLoggedIn': true, 'name': user.name};
    } else {
      return {'isLoggedIn': false};
    }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return {
    //   "isLoggedIn": prefs.getBool('isLoggedIn') ?? false,
    //   'name': prefs.getString('name') ?? "",
    // };
  }
}
