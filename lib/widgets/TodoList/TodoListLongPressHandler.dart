import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/fns/showCustomDialog.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vibration/vibration.dart';

class TodoListLongPressHandler extends StatelessWidget {
  const TodoListLongPressHandler(this.widget, this.item);
  final Widget widget;
  final CustomListItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () async {
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate(duration: 25);
          }

          Config submitConfig = Config(
            callback: () {
              context.read<Todos>().removeItem(item);
              Navigator.pop(context);
            },
            text: 'Yes',
          );

          Config cancelConfig = Config(
            callback: () => Navigator.pop(context),
            text: 'No',
          );

          showCustomDialog(
            context,
            'Are you sure?',
            'Do you really want to delete this TODO? This action cannot be canceled',
            submitConfig,
            cancelConfig,
          );
        },
        child: widget);
  }
}
