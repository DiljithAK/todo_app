import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/providers/login_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/simple_signin_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/auth/authentication_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider(database)),
        ChangeNotifierProvider(create: (_) => SimpleSigninProvider(database)),
        ChangeNotifierProvider(create: (_) => SettingsProvider(database)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final hintStyle = TextStyle(color: Colors.grey[500], fontSize: 20);
    return ScreenUtilInit(
      ensureScreenSize: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ProTracker',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: AppColors().linkWater),
        //   useMaterial3: true,
        // ),
        theme: ThemeData(
          brightness: Brightness.light,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: hintStyle,
          ),
          iconTheme: IconThemeData(color: Colors.grey[800], size: 24),
          fontFamily: 'Georgia',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors().paleBlue),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey[800],
            ),
            titleMedium: TextStyle(
              fontSize: 24.0,
              color: Colors.grey[800],
            ),
            bodyMedium: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
              color: Colors.grey[800],
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors().paleBlue,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: hintStyle,
          ),
          iconTheme: IconThemeData(color: AppColors().appWhite, size: 24),
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w400,
              color: AppColors().appWhite,
            ),
            titleMedium: TextStyle(
              fontSize: 24.0,
              color: AppColors().appWhite,
            ),
            bodyMedium: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Hind',
              color: AppColors().appWhite,
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        home: const AuthenticationWrapper(),
      ),
    );
  }
}
