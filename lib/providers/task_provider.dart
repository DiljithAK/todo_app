import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final taskFormKey = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  int editIndex = 0;
  bool isUpdate = false;

  final List<Map<String, dynamic>> todoTaskList = [
    {
      "taskName": "Task 1",
      "taskDes": "First Task Des",
      "isCompleted": true,
    },
    {
      "taskName": "Task 2",
      "taskDes": "Second Task Des",
      "isCompleted": false,
    },
    {
      "taskName": "Task 3",
      "taskDes": "Third Task Des",
      "isCompleted": false,
    },
    {
      "taskName": "Task 4",
      "taskDes": "Fourth Task Des",
      "isCompleted": false,
    },
  ];

  void addTask() {
    String taskName = taskNameController.text;
    String taskdes = taskDescriptionController.text;
    todoTaskList.add({
      "taskName": taskName,
      "taskDes": taskdes,
      "isCompleted": false,
    });
    notifyListeners();
  }

  void setUpdateVal(index) {
    taskNameController.text = todoTaskList[index]['taskName'];
    taskDescriptionController.text = todoTaskList[index]['taskDes'];
    isUpdate = true;
    editIndex = index;
    notifyListeners();
  }

  void updateTask() {
    String taskName = taskNameController.text;
    String taskDes = taskDescriptionController.text;
    todoTaskList[editIndex]['taskName'] = taskName;
    todoTaskList[editIndex]['taskDes'] = taskDes;
    notifyListeners();
  }

  void changeTaskStatus(bool? isCompleted, int index) {
    todoTaskList[index]['isCompleted'] = isCompleted ?? false;
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
}
