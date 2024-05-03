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

  @Query(
      'UPDATE Task SET status = CASE WHEN status = 1 THEN 2 ELSE 1 END WHERE id = :taskId')
  Future<void> toggleTaskStatus(int taskId);

  @delete
  Future<void> deleteTask(Task task);

  @Query('SELECT * FROM Task WHERE id = :taskId')
  Future<Task?> findTaskById(int taskId);

  @transaction
  Future<void> deleteOrUpdateTask(int taskId) async {
    final Task? task = await findTaskById(taskId);
    if (task != null) {
      if (task.isSync == 1) {
        task.markAsSynced();
        await updateTask(task);
      } else {
        await deleteTask(task);
      }
    }
  }
}
