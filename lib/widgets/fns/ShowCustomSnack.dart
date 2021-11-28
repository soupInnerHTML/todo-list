import 'package:flutter/material.dart';

showCustomSnack(
    BuildContext context,
    void Function() onPressed,
    String content,
    {String label = 'UNDO'}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: label,
        textColor: Colors.blue,
        onPressed: onPressed,
      ),
    ),
  );
}
