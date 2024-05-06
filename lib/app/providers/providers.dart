import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/database/database.dart';
import 'package:todo_app/app/app.dart';
import 'package:todo_app/app/providers/login_provider.dart';
import 'package:todo_app/app/providers/settings_provider.dart';
import 'package:todo_app/app/providers/simple_signin_provider.dart';
import 'package:todo_app/app/providers/task_provider.dart';

class AppProviders extends StatelessWidget {
  final AppDatabase database;

  const AppProviders({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider(database)),
        ChangeNotifierProvider(create: (_) => SimpleSigninProvider(database)),
        ChangeNotifierProvider(create: (_) => SettingsProvider(database)),
      ],
      child: const MyApp(),
    );
  }
}
