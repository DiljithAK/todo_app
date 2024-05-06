import 'package:flutter/material.dart';

class AppColors {
  late Color linkWater;
  late Color appWhite;
  late Color paleBlue;

  AppColors() {
    linkWater = materialColor("#fff0f4fc");
    paleBlue = materialColor("#ffBad1f6");
    appWhite = materialColor("#ffffffff");
  }

  Color materialColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    int hexColorInt = int.parse(hexColor, radix: 16);
    return MaterialColor(hexColorInt, {
      50: Color(hexColorInt).withOpacity(0.1),
      100: Color(hexColorInt).withOpacity(0.2),
      200: Color(hexColorInt).withOpacity(0.3),
      300: Color(hexColorInt).withOpacity(0.4),
      400: Color(hexColorInt).withOpacity(0.5),
      500: Color(hexColorInt).withOpacity(0.6),
      600: Color(hexColorInt).withOpacity(0.7),
      700: Color(hexColorInt).withOpacity(0.8),
      800: Color(hexColorInt).withOpacity(0.9),
      900: Color(hexColorInt).withOpacity(1),
    });
  }
}
