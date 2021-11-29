import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/fns/showCustomDialog.dart';
import 'package:provider/provider.dart';

class TodoListColumn extends StatefulWidget {
  @override
  _TodoListColumnState createState() {
    return _TodoListColumnState();
  }
}

class _TodoListColumnState extends State<TodoListColumn> {
  @override
  Widget build(BuildContext context) {
    TodosList data = context.watch<Todos>().getData();
    int selectedLength = context.read<Todos>().getSelectedLength();

    return Visibility(
      visible: selectedLength > 0,
      child: Row(children: [
        Text.rich(
          TextSpan(
              text:
                  '$selectedLength/${data.length}'),
          style: TextStyle(color: Colors.grey),
        ),
        IconButton(
          color: Colors.red,
          icon: Icon(Icons.delete),
          onPressed: () {
            Config submitConfig = Config(
              callback: () {
                context.read<Todos>().removeSelected();
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
              selectedLength > 1 ?
                'Do you really want to delete all these TODOs? This action cannot be canceled' :
                'Do you really want to delete this TODO? This action cannot be canceled',
              submitConfig,
              cancelConfig,
            );
          },
        ),
      ]),
    );
  }
}
