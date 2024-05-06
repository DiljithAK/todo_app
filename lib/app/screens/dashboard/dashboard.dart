import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/constants/colors.dart';
import 'package:todo_app/app/providers/settings_provider.dart';
import 'package:todo_app/app/providers/task_provider.dart';
import 'package:todo_app/app/screens/dashboard/widget/bottom_sheet.dart';
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
  late SettingsProvider _settingsProvider;

  @override
  void initState() {
    super.initState();
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    _taskProvider.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: TodoAppBar(
        title: "Hi, ${widget.username}",
        onMenuFun: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: Drawer(
        // Add your drawer content here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors().paleBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ProTasker',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Georgia',
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    'Version: 1.0.0',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: DropdownButton<String>(
                value: _settingsProvider.selectedTheme,
                icon: const Icon(Icons.expand_more),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Georgia',
                ),
                underline: Container(),
                onChanged: (String? newValue) {
                  _settingsProvider.selectTheme(newValue);
                  // setState(() {
                  //   dropdownValue = newValue!;
                  // });
                },
                items: _settingsProvider.themeList
                    .map<DropdownMenuItem<String>>((Map<String, String> map) {
                  String key = map.keys.first;
                  String value = map[key]!;
                  return DropdownMenuItem<String>(
                      value: key, child: Text(value));
                }).toList(),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Consumer<TaskProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (value.todoTaskList.isEmpty) {
          return const NoTaskFound();
        }
        return Center(
          child: ListView.builder(
            itemCount: value.todoTaskList.length,
            itemBuilder: (context, index) {
              final item = value.todoTaskList[index];
              return TaskTile(
                item: item,
                index: index,
              );
            },
          ),
        );
      }),
      floatingActionButton: CustomFloatingButton(
        onClickBtn: () => showBottonSheet(context, "Add Task"),
      ),
    );
  }
}
