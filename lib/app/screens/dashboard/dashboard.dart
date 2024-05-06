import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/core/providers/task_provider.dart';
import 'package:todo_app/app/screens/dashboard/widget/bottom_sheet.dart';
import 'package:todo_app/app/screens/dashboard/widget/custom_end_drawer.dart';
import 'package:todo_app/app/screens/dashboard/widget/task_tile.dart';
import 'package:todo_app/app/screens/widget/custom_floating_button.dart';
import 'package:todo_app/app/screens/widget/no_task_found.dart';
import 'package:todo_app/app/screens/widget/todo_app_bar.dart';

class Dashboard extends StatefulWidget {
  final String username;
  const Dashboard({super.key, required this.username});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TaskProvider _taskProvider;
  
  final Widget _loadingIndicator = const Center(child: CircularProgressIndicator());
  final Widget _noTaskFound = const NoTaskFound();

  @override
  void initState() {
    super.initState();
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _taskProvider.getTaskList();
  }

  void _openDrawer() => _scaffoldKey.currentState?.openEndDrawer();

  @override
  Widget build(BuildContext context) {
    final String title = "Hi, ${widget.username}";

    return Scaffold(
      key: _scaffoldKey,
      appBar: TodoAppBar(title: title, onMenuFun: () => _openDrawer()),
      endDrawer: const CustomEndDrawer(),
      body: Consumer<TaskProvider>(builder: (context, value, child) {
        if (value.isLoading) return _loadingIndicator;
        if (value.todoTaskList.isEmpty) return _noTaskFound;
        return Center(
          child: ListView.builder(
              itemCount: value.todoTaskList.length,
              itemBuilder: (context, index) {
                final item = value.todoTaskList[index];
                return TaskTile(item: item, index: index);
              }),
        );
      }),
      floatingActionButton: CustomFloatingButton(
        onClickBtn: () => showBottonSheet(context, "Add Task"),
      ),
    );
  }
}
