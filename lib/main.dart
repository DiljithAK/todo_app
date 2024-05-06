import 'package:flutter/material.dart';
import 'package:todo_app/app/database/database_initializer.dart';
import 'package:todo_app/app/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await DatabaseInitializer.initialize();
  runApp(AppProviders(database: database));
}
