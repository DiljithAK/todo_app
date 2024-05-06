
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/providers/settings_provider.dart';
import 'package:todo_app/app/screens/auth/authentication_wrapper.dart';
import 'package:todo_app/app/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ProTracker',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: settingsProvider.appThemeMode,
          home: const AuthenticationWrapper(),
        ),
      ),
    );
  }
}
