import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todos.dart';
import 'package:flutter_application_1/widgets/fns/ShowCustomSnack.dart';
import 'package:flutter_application_1/widgets/fns/showCustomDialog.dart';
import 'package:flutter_application_1/widgets/fns/showModal.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vibration/vibration.dart';

class TodoList extends StatefulWidget {
  @override
  TodoListState createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<Todos>().getData();

    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Visibility(
            visible: data.any((element) => element.isSelected),
            child: IconButton(
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
                  'Do you really want to delete all these TODOs? This action cannot be canceled',
                  submitConfig,
                  cancelConfig,
                );
              },
            ),
          ),
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
            DataCell(
              GestureDetector(
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
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(item.text),
                      Row(children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            context.read<Todos>().removeItem(item);
                            showCustomSnack(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showModal(
                                context,
                                'Edit',
                                (listItemText) => context
                                    .read<Todos>()
                                    .editItem(item, listItemText),
                                item.text);
                          },
                        )
                      ])
                    ],
                  ),
                ),
              ),
            )
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
