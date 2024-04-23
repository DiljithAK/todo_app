import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/widget/custom_floating_button.dart';
import 'package:todo_app/ui/widget/custom_input_field.dart';
import 'package:todo_app/ui/widget/submit_button.dart';
import 'package:todo_app/ui/widget/todo_app_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TodoAppBar(
        title: "ProTasker",
        onMenuFun: () => log("Menu Icon Pressed!!!"),
      ),
      body: Consumer<TaskProvider>(builder: (context, value, child) {
        return Center(
          child: ListView.builder(
            itemCount: value.todoTaskList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  onChanged: (val) {
                    value.changeTaskStatus(val, index);
                  },
                  value: value.todoTaskList[index]['isCompleted'],
                ),
                title: Text(
                  value.todoTaskList[index]['taskName']!,
                  style: value.todoTaskList[index]['isCompleted']
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                ),
                subtitle: Text(
                  value.todoTaskList[index]['taskDes']!,
                  style: value.todoTaskList[index]['isCompleted']
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => value.removeTask(index),
                ),
                onTap: () {
                  value.setUpdateVal(index);
                  _showBottonSheet(context);
                },
              );
            },
          ),
        );
      }),
      floatingActionButton: CustomFloatingButton(
        onClickBtn: () => _showBottonSheet(context),
      ),
    );
  }
}

void _showBottonSheet(BuildContext context) {
  final hundredPercentageWidth = MediaQuery.of(context).size.width * 1;
  final bottonSheetHeight = MediaQuery.of(context).size.height * 0.5;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer<TaskProvider>(builder: (context, value, child) {
        return Container(
          width: hundredPercentageWidth,
          height: bottonSheetHeight,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: value.taskFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: CustomInputField(
                    controller: value.taskNameController,
                    hintText: "Task name",
                    fieldValidator: (value) {
                      if (value == null || value == "") {
                        return 'This field is required!';
                      }
                      return null;
                    },
                  ),
                ),
                // const SizedBox(height: 10),
                Expanded(
                  child: CustomInputField(
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    controller: value.taskDescriptionController,
                    hintText: "Task description",
                    fieldValidator: (value) {
                      if (value == null || value == "") {
                        return 'This field is required!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SubmitButton(
                  width: hundredPercentageWidth,
                  height: 45,
                  onBtnPress: () {
                    if (value.taskFormKey.currentState!.validate()) {
                      if (value.isUpdate) {
                        value.updateTask();
                      } else {
                        value.addTask();
                      }
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      });
    },
  ).then((value) {
    Provider.of<TaskProvider>(context, listen: false).clearTaskFields();
  });
}
