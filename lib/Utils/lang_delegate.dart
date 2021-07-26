import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  //Helper methode to keep the code in the widget concise
  //Localization are accessed using inherited widget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  //Static member to have simple access to delegate from material app
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future load() async {
    //Load the language json file fron the lang folder
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

//LocalizationsDelegate is a factory for a set of localized resources
//In this case, the localized strings will be gotten in the AppLocalization object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  //This delegate instance will never change as it does not have a field
  //It can provide a constant constructor
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    //Includes all supported language code
    return ['en', 'hi', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    //AppLocalization class is where the json string actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
