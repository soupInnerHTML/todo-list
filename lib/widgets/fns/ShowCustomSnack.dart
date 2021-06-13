import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todos.dart';
import 'package:provider/provider.dart';

showCustomSnack(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('TODO was deleted'),
      action: SnackBarAction(
        label: 'UNDO',
        textColor: Colors.blue,
        onPressed: () {
          context.read<Todos>().resetData();
        },
      ),
    ),
  );
}
