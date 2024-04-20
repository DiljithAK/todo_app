import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onClickBtn;

  const CustomFloatingButton({super.key, required this.onClickBtn});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onClickBtn,
      shape: const CircleBorder(),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}
