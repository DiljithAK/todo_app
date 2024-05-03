import 'package:flutter/material.dart';

class NoTaskFound extends StatelessWidget {
  const NoTaskFound({super.key});

  @override
  Widget build(BuildContext context) {
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
}
