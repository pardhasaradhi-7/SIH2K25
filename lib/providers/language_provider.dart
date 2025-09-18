import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? _locale; // initially null

  Locale? get locale => _locale;

  String get currentLanguage => _locale?.languageCode ?? 'en';

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
