import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('ar');

  bool get isDark => themeMode == ThemeMode.dark;
  bool get isArabic => locale.languageCode == 'ar';

  void toggleTheme(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeLanguage(bool arabic) {
    locale = arabic ? const Locale('ar') : const Locale('en');
    notifyListeners();
  }
}
