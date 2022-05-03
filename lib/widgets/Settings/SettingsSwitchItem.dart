import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Settings.dart';
import 'package:flutter_application_1/widgets/Settings/SettingsBody.dart';
import 'package:provider/provider.dart';

class SettingsSwitchItem extends StatelessWidget {
  final String text;
  final void Function(bool) onCheck;
  final bool checked;
  SettingsSwitchItem(this.text, {required this.checked, required this.onCheck});

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: () => onCheck(!checked),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
          CupertinoSwitch(
            value: checked,
            onChanged: onCheck,
            activeColor: context.watch<Settings>().primarySwatch,
          ),
        ],
      ),
    );
  }
}
