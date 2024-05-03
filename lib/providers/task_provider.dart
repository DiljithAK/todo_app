import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/models/local_models/task_model.dart';
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

  void updateTask() {
    // String taskName = taskNameController.text;
    // String taskDes = taskDescriptionController.text;
    // todoTaskList[editIndex].taskName = taskName;
    // todoTaskList[editIndex].taskDescription = taskDes;
    notifyListeners();
  }

  void changeTaskStatus(bool? isCompleted, int index) {
    // todoTaskList[index].status = isCompleted ?? false;
    notifyListeners();
  }

  void removeTask(int index) {
    todoTaskList.removeAt(index);
    notifyListeners();
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
    inspect(task);
    // final response = await TaskService.getTaskList();
    // List<Map<String, dynamic>> mapList = convertList(response['data']);
    // todoTaskList = mapList;
    isLoading = false;
    notifyListeners();
  }

  void getTaskListWithoutLoading() async {
    final task = await database.taskDao.findAllTasks();
    todoTaskList = task;
  }

  List<Map<String, dynamic>> convertList(List<dynamic> list) {
    return list.map((item) => item as Map<String, dynamic>).toList();
  }
}
