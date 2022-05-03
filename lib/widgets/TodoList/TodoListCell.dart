import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';

class TodoListCell extends StatelessWidget {
  final CustomListItem item;
  TodoListCell(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item.text,
              style: Theme.of(context).textTheme.subtitle1,
            )));
  }
}
