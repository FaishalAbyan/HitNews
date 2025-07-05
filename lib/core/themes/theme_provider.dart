import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default tema adalah terang

  ThemeMode get themeMode => _themeMode;

  // Mengubah mode tema
  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Beri tahu listener (UI) bahwa tema berubah
  }

  // Metode opsional untuk mengatur tema secara langsung
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }
}
