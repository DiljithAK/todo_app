import 'package:flutter/material.dart';
import 'package:todo_app/app/database/database.dart';
import 'package:todo_app/app/models/local_models/task_model.dart';
// import 'package:todo_app/services/all_services/task_service.dart';

class TaskProvider with ChangeNotifier {
  final AppDatabase database;

  TaskProvider(this.database);

  // Form
  final taskFormKey = GlobalKey<FormState>();
  // Form field controllers
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  // Helper variables
  int editIndex = 0;
  bool isUpdate = false;
  bool isLoading = false;

  List<Task> todoTaskList = [];

  void addTask() async {
    String taskName = taskNameController.text;
    String taskdes = taskDescriptionController.text;
    final task = Task(taskName: taskName, taskDescription: taskdes, status: 1);
    await database.taskDao.insertTask(task);
    getTaskListWithoutLoading();
    notifyListeners();
  }

  void setUpdateVal(index) {
    taskNameController.text = todoTaskList[index].taskName;
    taskDescriptionController.text = todoTaskList[index].taskDescription;
    isUpdate = true;
    editIndex = index;
    notifyListeners();
  }

  void updateTask() async {
    int id = todoTaskList[editIndex].id!;
    String taskName = taskNameController.text;
    String taskDes = taskDescriptionController.text;
    int status = todoTaskList[editIndex].status;
    final task = Task(
        id: id, taskName: taskName, taskDescription: taskDes, status: status);
    await database.taskDao.updateTask(task);
    getTaskListWithoutLoading();
  }

  void changeTaskStatus(int index) async {
    final taskId = todoTaskList[index].id!;
    await database.taskDao.toggleTaskStatus(taskId);
    getTaskListWithoutLoading();
  }

  void removeTask(int index) async {
    final taskId = todoTaskList[index].id!;
    await database.taskDao.deleteOrUpdateTask(taskId);
    getTaskListWithoutLoading();
  }

  void clearTaskFields() {
    taskNameController.clear();
    taskDescriptionController.clear();
    isUpdate = false;
    editIndex = 0;
  }

  void getTaskList() async {
    isLoading = true;
    final task = await database.taskDao.findAllTasks();
    todoTaskList = task;
    isLoading = false;
    notifyListeners();
  }

  void getTaskListWithoutLoading() async {
    final task = await database.taskDao.findAllTasks();
    todoTaskList = task;
    notifyListeners();
  }

  List<Map<String, dynamic>> convertList(List<dynamic> list) {
    return list.map((item) => item as Map<String, dynamic>).toList();
  }
}
