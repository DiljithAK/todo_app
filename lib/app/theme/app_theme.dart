import 'package:flutter/material.dart';
import 'package:todo_app/app/constants/colors.dart';

class AppThemes {
  static final _hintStyle = TextStyle(color: Colors.grey[500], fontSize: 20);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: _hintStyle,
    ),
    iconTheme: IconThemeData(color: Colors.grey[800], size: 24),
    fontFamily: 'Georgia',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors().paleBlue),
    textTheme: _lightTextTheme,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors().paleBlue,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: _hintStyle,
    ),
    iconTheme: IconThemeData(color: AppColors().appWhite, size: 24),
    fontFamily: 'Georgia',
    textTheme: _darkTextTheme,
  );

  static final TextTheme _lightTextTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400, color: Colors.grey[800]),
    titleMedium: TextStyle(fontSize: 24.0, color: Colors.grey[800]),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.grey[800]),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400, color: AppColors().appWhite),
    titleMedium: TextStyle(fontSize: 24.0, color: AppColors().appWhite),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: AppColors().appWhite),
  );
}
