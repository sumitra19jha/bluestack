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
      ],
      child: Consumer<AppLanguage>(
        builder: (context, model, child) => MaterialApp(
          supportedLocales: [
            Locale('en', 'US'),
            Locale('hi', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: AuthPage(),
        ),
      ),
    );
  }
}
