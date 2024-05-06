import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/models/local_models/task_model.dart';
import 'package:todo_app/app/providers/task_provider.dart';
import 'package:todo_app/app/screens/dashboard/widget/bottom_sheet.dart';

class TaskTile extends StatelessWidget {
  final Task item;
  final int index;

  const TaskTile({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, value, child) {
      return Dismissible(
        key: Key(item.id.toString()),
        background: Container(
          color: Colors.red[300],
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 30),
          child: const Icon(Icons.delete, color: Colors.black),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          value.removeTask(index);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text("Task removed successfully."),
            action: SnackBarAction(
              label: 'Done',
              onPressed: () {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
              },
            ),
          ));
        },
        child: ListTile(
          leading: Checkbox(
            onChanged: (val) {
              value.changeTaskStatus(index);
            },
            value: (value.todoTaskList[index].status == 2),
          ),
          title: Text(
            value.todoTaskList[index].taskName,
            style: (value.todoTaskList[index].status == 2)
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  )
                : null,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            value.todoTaskList[index].taskDescription,
            style: (value.todoTaskList[index].status == 2)
                ? const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  )
                : null,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: Icon(Icons.sync, color: Colors.blue[400]),
          onTap: () {
            value.setUpdateVal(index);
            showBottonSheet(context, "Update Task");
          },
        ),
      );
    });
  }
}
