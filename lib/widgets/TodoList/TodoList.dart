import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/TodoList/TodoListColumn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/widgets/TodoList/TodoListCell.dart';

class TodoList extends StatefulWidget {
  @override
  TodoListState createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    TodosList data = context.watch<Todos>().getData();

    return DataTable(
      headingRowHeight: 70,
      dataRowHeight: 70,
      horizontalMargin: 0,
      checkboxHorizontalMargin: 25,
      showBottomBorder: data.length > 0,
      dataTextStyle: TextStyle(fontSize: 16, color: Colors.black),
      columns: <DataColumn>[
        DataColumn(
          label: TodoListColumn(),
        ),
      ],
      rows: List<DataRow>.generate(data.length, (int index) {
        var item = data[index];
        return DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              // All rows will have the same selected color.
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              }
              return null; // Use default value for other states and odd rows.
            },
          ),
          cells: <DataCell>[
            DataCell(TodoListCell(item))
          ],
          selected: item.isSelected,
          onSelectChanged: (bool? value) {
            context.read<Todos>().changeIsSelected(item, value!);
          },
        );
      }),
    );
  }
}
