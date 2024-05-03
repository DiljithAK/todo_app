import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String taskName;
  final String taskDescription;
  final int status;
  final int isSync;

  Task({
    this.id,
    required this.taskName,
    required this.taskDescription,
    this.status = 1,
    this.isSync = 0,
  });
}
