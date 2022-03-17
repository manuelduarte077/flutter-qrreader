import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({
    required bool isDarkMode,
  }) : currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

  setLightMode() {
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = ThemeData.dark();
    notifyListeners();
  }
}
