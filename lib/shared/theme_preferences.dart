import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static late SharedPreferences _prefs;

  // Propiedades
  static bool _isDarkMode = false;

  // Inicialización
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Dark Mode
  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }
}
