import 'package:flutter/material.dart';

class TodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuFun;

  const TodoAppBar({super.key, required this.title, required this.onMenuFun});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: IconButton(
            onPressed: onMenuFun,
            icon: const Icon(Icons.sort),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
