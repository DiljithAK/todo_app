import 'package:flutter/material.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/models/local_models/user_model.dart';

class SimpleSigninProvider with ChangeNotifier {
  final AppDatabase database;

  SimpleSigninProvider(this.database);

  // Form
  final simpleSigninFormKey = GlobalKey<FormState>();
  // Form field controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<User?> insertUser() async {
    final name = usernameController.text;
    final ageString = ageController.text;
    final age = int.parse(ageString); 
    final user = User(name: name, age: age);
    await database.userDao.insertUser(user);
    final currentUser = await database.userDao.findCurrentUser();
    return currentUser.user;
  }

  Future<User?> getCurrentUser() async {
    final currentUser = await database.userDao.findCurrentUser();
    return currentUser.user;
  }
}
