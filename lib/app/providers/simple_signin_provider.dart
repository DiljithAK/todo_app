import 'package:flutter/material.dart';
import 'package:todo_app/app/database/database.dart';
import 'package:todo_app/app/models/local_models/user_model.dart';

class SimpleSigninProvider with ChangeNotifier {
  final AppDatabase database;

  SimpleSigninProvider(this.database);

  // Form
  final simpleSigninFormKey = GlobalKey<FormState>();
  // Form field controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<bool?> insertUser() async {
    final name = usernameController.text;
    final ageString = ageController.text;
    try {
      final age = int.parse(ageString);
      final user = User(name: name, age: age);
      await database.userDao.insertUser(user);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<User?> getCurrentUser() async {
    final currentUser = await database.userDao.findCurrentUser();
    return currentUser.user;
  }
}
