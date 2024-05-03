import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/ui/dashboard/widget/bottom_sheet.dart';
import 'package:todo_app/ui/dashboard/widget/task_tile.dart';
import 'package:todo_app/ui/widget/custom_floating_button.dart';
import 'package:todo_app/ui/widget/todo_app_bar.dart';

class Dashboard extends StatefulWidget {
  final String username;

  const Dashboard({super.key, required this.username});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late TaskProvider _taskProvider;

  @override
  void initState() {
    super.initState();
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _taskProvider.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TodoAppBar(
        title: "Hi, ${widget.username}",
        onMenuFun: () => log("Menu Icon Pressed!!!"),
      ),
      body: Consumer<TaskProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (value.todoTaskList.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "No task found!",
                  style: TextStyle(fontSize: 18),
                ),
                Text("Please add task."),
              ],
            ),
          );
        }
        return Center(
          child: ListView.builder(
            itemCount: value.todoTaskList.length,
            itemBuilder: (context, index) {
              final item = value.todoTaskList[index];
              final taskName = value.todoTaskList[index].taskName;
              return TaskTile(
                item: item,
                taskName: taskName,
                index: index,
              );
            },
          ),
        );
      }),
      floatingActionButton: CustomFloatingButton(
        onClickBtn: () => showBottonSheet(context),
      ),
    );
  }
}
