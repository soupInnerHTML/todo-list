import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_application_1/widgets/Settings/SettingsBody.dart';
import 'package:flutter_application_1/models/Settings.dart' as SettingsModel;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/preventFlashesOnThemeSwitch.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late Animation<Color>? color;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    color = ColorTween(begin: startColor, end: endColor).animate(controller)
        as Animation<Color>;
  }

  void animateColor() {
    controller.forward();
    color?.drive(ColorTween(begin: Colors.indigo, end: Colors.red));
  }

  get startColor => _startColor;
  set startColor(_color) {
    color?.drive(ColorTween(begin: startColor, end: endColor));
    return _color;
  }

  Color _startColor = Colors.indigo;

  get endColor => _endColor;
  set endColor(_color) {
    color?.drive(ColorTween(begin: startColor, end: endColor));
    return _color;
  }

  Color _endColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    endColor = context.watch<SettingsModel.Settings>().primarySwatch;

    print(endColor.toString() + ' ' + startColor.toString());
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: context.watch<SettingsModel.Settings>().primarySwatch,
        backgroundColor: color?.value,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(
            color: preventFlashesOnThemeSwitch(context, Colors.white),
            fontSize: 24.0,
          ),
        ),
        brightness: Brightness.light, //white icons in status bar
      ),
      body: SettingsBody(),
    );
  }
}
