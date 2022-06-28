import 'package:flutter/material.dart';

Color? preventFlashesOnThemeSwitch(BuildContext context, Color color,
    {Brightness base = Brightness.dark}) {
  return Theme.of(context).brightness == base ? color : null;
}
