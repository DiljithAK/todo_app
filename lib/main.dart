import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/providers/login_provider.dart';
import 'package:todo_app/providers/simple_signin_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/auth/authentication_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider(database)),
        ChangeNotifierProvider(create: (_) => SimpleSigninProvider(database)),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ProTracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors().linkWater),
          useMaterial3: true,
        ),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}
