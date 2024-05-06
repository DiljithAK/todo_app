import 'package:flutter/material.dart';
import 'package:todo_app/app/database/database.dart';
import 'package:todo_app/app/models/local_models/settings_model.dart';

class SettingsProvider with ChangeNotifier {
  final AppDatabase database;

  SettingsProvider(this.database);

  final List<Map<String, String>> themeList = [
    {'system': 'System'},
    {'dark': 'Dark'},
    {'light': 'Light'}
  ];
  String selectedTheme = 'system';
  int? settingsId;

  ThemeMode appThemeMode = ThemeMode.system;

  bool systemTheme = true;
  bool darkTheme = false;
  bool lightTheme = false;

  void selectTheme(String? value) async {
    selectedTheme = value!;
    await updateTheme();
    notifyListeners();
  }

  void selectSignupTheme(bool value, String theme) {
    switch (theme) {
      case 'system':
        systemTheme = true;
        darkTheme = false;
        lightTheme = false;
        selectedTheme = 'system';
        break;
      case 'dark':
        systemTheme = false;
        darkTheme = true;
        lightTheme = false;
        selectedTheme = 'dark';
        break;
      case 'light':
        systemTheme = false;
        darkTheme = false;
        lightTheme = true;
        selectedTheme = 'light';
        break;
    }
    notifyListeners();
  }

  Future<void> insertTheme() async {
    final settings = Settings(theme: selectedTheme);
    await database.settingsDao.insertSettings(settings);
    appThemeMode = systemTheme
        ? ThemeMode.system
        : darkTheme
            ? ThemeMode.dark
            : ThemeMode.light;
    notifyListeners();
  }

  Future<bool> setTheme() async {
    final settings = await database.settingsDao.findCurrentSettings();
    if (settings.settings != null) {
      settingsId = settings.settings!.id;
      return true;
    } else {
      await insertTheme();
      return false;
    }
  }

  Future<void> updateTheme() async {
    final isUpdate = await setTheme();
    if (isUpdate) {
      final settings = Settings(id: settingsId, theme: selectedTheme);
      await database.settingsDao.updateSettings(settings);
      appThemeMode = systemTheme
          ? ThemeMode.system
          : darkTheme
              ? ThemeMode.dark
              : ThemeMode.light;
      notifyListeners();
    }
  }
}
