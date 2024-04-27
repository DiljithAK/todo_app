import 'package:flutter/material.dart';
import 'package:todo_app/services/all_services/task_service.dart';

class TaskProvider with ChangeNotifier {
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

  List<Map<String, dynamic>> todoTaskList = [];

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
    taskNameController.text = todoTaskList[index]['task_name'];
    taskDescriptionController.text = todoTaskList[index]['task_description'];
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

  void getTaskList() async {
    isLoading = true;
    final response = await TaskService.getTaskList();
    List<Map<String, dynamic>> mapList = convertList(response['data']);
    todoTaskList = mapList;
    isLoading = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> convertList(List<dynamic> list) {
    return list.map((item) => item as Map<String, dynamic>).toList();
  }
}
