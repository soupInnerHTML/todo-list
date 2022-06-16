import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/TodoList/TodoListCellSlidable.dart';
import 'package:flutter_application_1/widgets/TodoList/TodoListColumn.dart';
import 'package:flutter_application_1/widgets/TodoList/TodoListLongPressHandler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/widgets/TodoList/TodoListCell.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Todos todos = context.read<Todos>();
    TodosList data = todos.getData();

    return DataTable(
      headingRowHeight: 70,
      dataRowHeight: 70,
      horizontalMargin: 0,
      checkboxHorizontalMargin: 25,
      onSelectAll: (value) {
        todos.selectAll(value!);
      },
      // dataTextStyle: TextStyle(fontSize: 16, color: Colors.black),
      columns: <DataColumn>[
        DataColumn(
          label: TodoListColumn(),
        ),
      ],
      rows: List<DataRow>.generate(
        data.length,
        (int index) {
          var item = data[index];
          return DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                // All rows will have the same selected color.
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08);
                }
                return null; // Use default value for other states and odd rows.
              },
            ),
            cells: <DataCell>[
              DataCell(TodoListLongPressHandler(
                  TodoListCellSlideable(widget: TodoListCell(item), item: item),
                  item))
            ],
            selected: item.isDone,
            onSelectChanged: (value) {
              todos.changeIsDone(item, value!);
            },
          );
        },
      ),
    );
  }
}
