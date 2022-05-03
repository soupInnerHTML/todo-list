import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Settings/SettingsBody.dart';
import 'package:flutter_application_1/models/Settings.dart' as SettingsModel;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<SettingsModel.Settings>().primarySwatch,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        brightness: Brightness.dark, //white icons in status bar
      ),
      body: SettingsBody(),
    );
  }
}
