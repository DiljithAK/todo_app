import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_app/app/core/database/settings_dao.dart';
import 'package:todo_app/app/core/database/task_dao.dart';
import 'package:todo_app/app/core/database/user_dao.dart';

import '../models/local_models/settings_model.dart';
import '../models/local_models/task_model.dart';
import '../models/local_models/user_model.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Task, User, GetUser, Settings])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
  UserDao get userDao;
  SettingsDao get settingsDao;
}
