import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui/auth/login_screen.dart';
import 'package:todo_app/ui/dashboard/dashboard.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final data = snapshot.data ?? {'isLoggedIn': false, 'name': ''};
        return data['isLoggedIn']
            ? Dashboard(username: data['name'] ?? "Blaa")
            : const LoginScreen();
      },
    );
  }

  Future<Map<String, dynamic>> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "isLoggedIn": prefs.getBool('isLoggedIn') ?? false,
      'name': prefs.getString('name') ?? "",
    };
  }
}
