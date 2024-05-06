import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app/constants/colors.dart';
import 'package:todo_app/app/providers/settings_provider.dart';
import 'package:todo_app/app/providers/simple_signin_provider.dart';
import 'package:todo_app/app/screens/dashboard/dashboard.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final signInProvider =
        Provider.of<SimpleSigninProvider>(context, listen: false);
    return Consumer<SettingsProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Theme'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ThemeContainer(
                bgColor: AppColors().linkWater,
                btnColor: AppColors().paleBlue,
                themName: "System",
                switchVal: value.systemTheme,
                switchFun: (val) => value.selectSignupTheme(val, 'system'),
              ),
              ThemeContainer(
                bgColor: Colors.black87,
                btnColor: Colors.indigo,
                activeTcolor: Colors.indigo,
                forGColor: AppColors().appWhite,
                themName: "Dark",
                switchVal: value.darkTheme,
                switchFun: (val) => value.selectSignupTheme(val, 'dark'),
              ),
              ThemeContainer(
                bgColor: AppColors().linkWater,
                btnColor: AppColors().paleBlue,
                themName: "Light",
                switchVal: value.lightTheme,
                switchFun: (val) => value.selectSignupTheme(val, 'light'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          // color: AppColors().linkWater,
          height: MediaQuery.of(context).size.width * 0.15,
          width: MediaQuery.of(context).size.width * 1,
          child: GestureDetector(
            onTap: () async {
              final user = await signInProvider.getCurrentUser();
              if (user != null && context.mounted) {
                await value.insertTheme();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(username: user.name)));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Failed to sign up user, please try again later."),
                ));
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Georgia',
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeContainer extends StatelessWidget {
  final Color bgColor;
  final String themName;
  final bool switchVal;
  final void Function(bool)? switchFun;
  final Color btnColor;
  final Color? forGColor;
  final Color? activeTcolor;

  const ThemeContainer({
    super.key,
    required this.bgColor,
    required this.themName,
    required this.switchVal,
    required this.switchFun,
    required this.btnColor,
    this.forGColor,
    this.activeTcolor,
  });

  @override
  Widget build(BuildContext context) {
    final boxHeight = MediaQuery.of(context).size.height * 0.2;
    final boxWidth = MediaQuery.of(context).size.width * 0.8;
    return Container(
      height: boxHeight,
      width: boxWidth,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: bgColor,
        // border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                themName,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.w400,
                  color: forGColor,
                ),
              ),
              Switch(
                value: switchVal,
                onChanged: switchFun,
                activeTrackColor: activeTcolor ?? AppColors().paleBlue,
                activeColor: AppColors().linkWater,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 45,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: Text(
                    'Title',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Georgia',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: btnColor,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: forGColor ?? Colors.grey[800],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
