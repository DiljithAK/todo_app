import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/constants/colors.dart';
import 'package:todo_app/app/core/providers/settings_provider.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    return Drawer(
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
              value: settingsProvider.selectedTheme,
              icon: const Icon(Icons.expand_more),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Georgia',
              ),
              underline: Container(),
              onChanged: (String? newValue) =>
                  settingsProvider.selectTheme(newValue),
              items: settingsProvider.themeList
                  .map<DropdownMenuItem<String>>((Map<String, String> map) {
                String key = map.keys.first;
                String value = map[key]!;
                return DropdownMenuItem<String>(value: key, child: Text(value));
              }).toList(),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
