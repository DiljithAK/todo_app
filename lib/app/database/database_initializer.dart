import 'package:todo_app/app/database/database.dart';

class DatabaseInitializer {
  static Future<AppDatabase> initialize() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database;
  }
}