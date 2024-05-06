import 'package:flutter/material.dart';

class AppScale {
  late EdgeInsets sPadding20;

  late BorderRadius bRadius10;
  AppScale() {
    sPadding20 = const EdgeInsets.symmetric(vertical: 20, horizontal: 20);

    bRadius10 = const BorderRadius.all(Radius.circular(10));
  }
}
