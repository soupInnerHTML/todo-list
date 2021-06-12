import 'package:flutter/material.dart';

class CustomListItem {
  String text;
  bool isSelected;
  CustomListItem(this.text, this.isSelected);
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => TodoListState();
}

/// This is the private State class that goes with MyStatefulWidget.
class TodoListState extends State<TodoList> {
  List<CustomListItem> data = [
    CustomListItem('1', false),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('TODOS'),
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
            }),
            cells: <DataCell>[DataCell(Text(item.text))],
            selected: item.isSelected,
            onSelectChanged: (bool? value) {
              setState(() {
                item.isSelected = value!;
              });
            },
          );
        }),
      ),
    );
  }
}
