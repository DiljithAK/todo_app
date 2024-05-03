import "package:floor/floor.dart";

import "../models/local_models/task_model.dart";

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> findAllTasks();

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(Task user);

  @Query('UPDATE Task SET status = CASE WHEN status = 1 THEN 2 ELSE 1 END WHERE id = :taskId')
  Future<void> toggleTaskStatus(int taskId);
}
