import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showCustomSnack(BuildContext context, void Function() onPressed, String content,
    {String? label}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(content),
      action: SnackBarAction(
        label: label is String
            ? label
            : AppLocalizations.of(context)!.undo.toUpperCase(),
        textColor: Colors.blue,
        onPressed: onPressed,
      ),
    ),
  );
}
