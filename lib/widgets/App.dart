import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/preventFlashesOnThemeSwitch.dart';
import 'package:flutter_application_1/widgets/MainPage.dart';
import 'package:flutter_application_1/widgets/Settings/Settings.dart';
import 'package:flutter_application_1/models/Settings.dart' as SettingsModel;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel.Settings>();
    return MaterialApp(
      onGenerateTitle: (context) {
        return AppLocalizations.of(context)!.appTitle;
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        // 'en' is the language code. We could optionally provide a
        // a country code as the second param, e.g.
        // Locale('en', 'US'). If we do that, we may want to
        // provide an additional app_en_US.arb file for
        // region-specific translations.
        const Locale('en', ''),
        const Locale('ru', ''),
      ],
      locale: settings.locale,
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => MainPage(),
        '/settings': (context) => Settings()
      },
      theme: ThemeData(
        brightness: settings.theme,
        primarySwatch: settings.primarySwatch,
        appBarTheme: AppBarTheme(
            // iconTheme: IconThemeData(
            // color: preventFlashesOnThemeSwitch(context, Colors.white,
            // base: Brightness.light),
            // )
            ),
      ),
    );
  }
}
