import "package:floor/floor.dart";

import "../models/local_models/task_model.dart";

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> findAllTasks();

  @insert
  Future<void> insertTask(Task task);
}
