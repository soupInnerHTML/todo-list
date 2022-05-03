import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Settings.dart';
import 'package:flutter_application_1/widgets/Settings/ColorPicker.dart';
import 'package:flutter_application_1/widgets/Settings/SettingsItem.dart';
import 'package:flutter_application_1/widgets/Settings/SettingsSwitchItem.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Pressable extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final double verticalPadding;
  const Pressable(
      {required this.child, required this.onTap, this.verticalPadding = 8.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
        child: child,
      ),
      onTap: onTap,
    );
  }
}

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final settings = context.read<Settings>();
    return Container(
      // padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          SettingsSwitchItem(l.darkTheme,
              checked: settings.theme == Brightness.dark, onCheck: (value) {
            settings.theme = (settings.theme == Brightness.dark
                ? Brightness.light
                : Brightness.dark);
          }),
          SettingsSwitchItem(l.removeTodo,
              checked: settings.removeCompletedTodo, onCheck: (value) {
            settings.removeCompletedTodo = value;
          }),
          SettingsItem(
            title: l.language,
            option: Localizations.localeOf(context).languageCode == 'ru'
                ? 'Русский'
                : 'English',
            actions: <SettingsItemAction>[
              SettingsItemAction(
                title: l.systemLanguage,
                onPressed: () => settings.locale = null,
              ),
              SettingsItemAction(
                title: 'Русский',
                onPressed: () => settings.locale = Locale("ru"),
              ),
              SettingsItemAction(
                title: 'English',
                onPressed: () => settings.locale = Locale("en"),
              )
            ],
          ),
          SettingsItem(
            title: l.addButtonPosition,
            option: settings.fabLocationParsed,
            actions: <SettingsItemAction>[
              SettingsItemAction(
                title: l.center,
                onPressed: () => settings.fabLocation =
                    FloatingActionButtonLocation.centerDocked,
              ),
              SettingsItemAction(
                title: l.left,
                onPressed: () => settings.fabLocation =
                    FloatingActionButtonLocation.startDocked,
              ),
              SettingsItemAction(
                title: l.right,
                onPressed: () => settings.fabLocation =
                    FloatingActionButtonLocation.endDocked,
              )
            ],
          ),
          ColorPicker(),
        ],
      ),
    );
  }
}
