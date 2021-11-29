import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/fns/showCustomDialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/widgets/fns/showCustomSnack.dart';
import 'package:flutter_application_1/widgets/fns/showModal.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vibration/vibration.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListCell extends StatefulWidget {
  final CustomListItem item;
  TodoListCell(this.item);

  @override
  _TodoListCellState createState() {
    return _TodoListCellState(this.item);
  }
}

class _TodoListCellState extends State<TodoListCell> {
  final CustomListItem item;
  _TodoListCellState(this.item);

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
      child: Slidable(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text(item.text)),
          ],
        ),
        endActionPane: ActionPane(
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                context.read<Todos>().removeItem(item);
                showCustomSnack(context, context.read<Todos>().resetData, 'TODO was deleted');
              },
              backgroundColor: Color(0xFFFE4A49),
              icon: Icons.delete,
            ),
            SlidableAction(
              onPressed: (BuildContext context) {
                showModal(
                    context,
                    'Edit',
                        (String listItemText) => context
                        .read<Todos>()
                        .editItem(item, listItemText),
                    item.text);
              },
              backgroundColor: Colors.blue,
              icon: Icons.edit,
            ),
          ],
          motion: BehindMotion(),
        ),
      ),
    );
  }
}
