import 'package:flutter/material.dart';

class DarkThemePreference extends ChangeNotifier {
  DarkThemePreference() {
    // loadValuesFromSharedPreferences();
  }

  bool light = false;
  void mytheme(bool color) {
    light = color;
    notifyListeners();
  }
}
