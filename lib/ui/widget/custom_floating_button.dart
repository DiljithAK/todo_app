import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onClickBtn;

  const CustomFloatingButton({super.key, required this.onClickBtn});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onClickBtn,
      shape: const CircleBorder(),
      backgroundColor: AppColors().paleBlue,
      foregroundColor: Colors.grey[800],
      child: const Icon(Icons.add),
    );
  }
}
