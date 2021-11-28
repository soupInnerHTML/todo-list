import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todos.dart';
import 'package:flutter_application_1/widgets/fns/ShowCustomSnack.dart';
import 'package:flutter_application_1/widgets/fns/showCustomDialog.dart';
import 'package:flutter_application_1/widgets/fns/showModal.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vibration/vibration.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      headingRowHeight: 70,
      dataRowHeight: 70,
      horizontalMargin: 0,
      checkboxHorizontalMargin: 25,
      showBottomBorder: data.length > 0,
      dataTextStyle: TextStyle(fontSize: 16, color: Colors.black),
      columns: <DataColumn>[
        DataColumn(
          label: Row(
            children: [
              Text.rich(TextSpan(
                  text: '${data.where((element) => element.isSelected).length}/${data.length}'),
                  style: TextStyle(
                    color: Colors.grey
                  ),
              ),
              Visibility(
                visible: data.any((element) => element.isSelected),
                child: IconButton(
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
                      'Do you really want to delete all these TODOs? This action cannot be canceled',
                      submitConfig,
                      cancelConfig,
                    );
                  },
                ),
              ),
            ],
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
            DataCell(GestureDetector(
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
            ))
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
