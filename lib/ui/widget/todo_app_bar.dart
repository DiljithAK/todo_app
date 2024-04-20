import 'package:flutter/material.dart';

class TodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuFun;

  const TodoAppBar({super.key, required this.title, required this.onMenuFun});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
          onPressed: onMenuFun,
          icon: const Icon(Icons.menu, color: Colors.white)),
      title: Center(
          child: Text(title, style: const TextStyle(color: Colors.white)))
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
