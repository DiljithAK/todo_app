import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_app/database/task_dao.dart';
import 'package:todo_app/database/user_dao.dart';
import 'package:todo_app/models/local_models/get_user_model.dart';
import 'package:todo_app/models/local_models/user_model.dart';
import '../models/local_models/task_model.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Task, User, GetUser])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
  UserDao get userDao;
}
