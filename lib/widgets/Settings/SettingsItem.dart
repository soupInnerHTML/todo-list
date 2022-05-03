import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'SettingsBody.dart';

class SettingsItemAction {
  String title;
  void Function() onPressed;
  SettingsItemAction({required this.title, required this.onPressed});
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String option;
  final List<SettingsItemAction> actions;
  const SettingsItem(
      {required this.title, required this.option, required this.actions});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final textStyle = Theme.of(context).textTheme.headline6;

    return Pressable(
      verticalPadding: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          Text(
            option,
            style: textStyle,
          ),
        ],
      ),
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                localization.cancel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: actions
                .map(
                  (e) => CupertinoActionSheetAction(
                    child: Text(
                      e.title,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      e.onPressed();
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
