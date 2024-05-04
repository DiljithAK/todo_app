import 'package:flutter/material.dart';
import 'package:todo_app/database/database.dart';

class SettingsProvider with ChangeNotifier {
  final AppDatabase database;

  SettingsProvider(this.database);

  final List<String> themeList = ['System', 'Dark', 'Light'];
  String selectedTheme = 'System';

  bool systemTheme = true;
  bool darkTheme = false;
  bool lightTheme = false;

  void selectTheme(String? value) {
    if (value != null) selectedTheme = value;
    notifyListeners();
  }

  void selectSignupTheme(bool value, String theme) {
    switch (theme) {
      case 'system':
        systemTheme = true;
        darkTheme = false;
        lightTheme = false;
        break;
      case 'dark':
        systemTheme = false;
        darkTheme = true;
        lightTheme = false;
        break;
      case 'light':
        systemTheme = false;
        darkTheme = false;
        lightTheme = true;
        break;
    }
    notifyListeners();
  }
}
