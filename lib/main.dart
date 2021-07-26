import 'package:bluestack/Provider/data-list.dart';
import 'package:bluestack/Provider/language.dart';
import 'package:bluestack/Provider/login.dart';
import 'package:bluestack/home.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bluestack/Utils/lang_controller.dart';
import 'package:bluestack/Utils/lang_delegate.dart';
import 'package:bluestack/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppLanguage()),
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: DataList()),
        ChangeNotifierProvider.value(value: AppLanguageController())
      ],
      child: Consumer<AppLanguageController>(
          builder: (context, lngcontrol, child) {
        lngcontrol.initialize();
        return Consumer<AppLanguage>(
          builder: (context, model, child) {
            Provider.of<LoginProvider>(context, listen: false).initialize();
            return MaterialApp(
              locale: Provider.of<AppLanguageController>(context).appLocal,
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ja', ''),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              localeResolutionCallback:
                  (Locale? locale, Iterable<Locale> supportedLocales) {
                if (locale == null) {
                  debugPrint("*language locale is null!!!");
                  return supportedLocales.first;
                }
                for (final Locale supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode ||
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              initialRoute: '/',
              home: Provider.of<LoginProvider>(context).isUserAlreadyLogged
                  ? HomeScreen()
                  : AuthPage(),
            );
          },
        );
      }),
    );
  }
}
