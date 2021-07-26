import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageController extends ChangeNotifier {
  Locale _appLocale = const Locale('en');
  Locale get appLocal => _appLocale;

  initialize() {
    fetchLocale();
  }

  fetchLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String langCode = prefs.getString('language_code') ?? 'en';
    _appLocale = Locale(langCode);
    notifyListeners();
    return Null;
  }

  Future<void> changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    if (type == const Locale("ja")) {
      //If selected language is spanish
      _appLocale = const Locale("ja");
      await prefs.setString('language_code', 'ja');
      await prefs.setString('countryCode', 'JP');
    } else {
      //If selected language is english
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }

    notifyListeners();
  }
}
