import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/fns/showCustomSnack.dart';
import 'package:flutter_application_1/widgets/fns/showModal.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class StatelessWidgetTodoCellWrap extends StatelessWidget {
  StatelessWidgetTodoCellWrap(
      {required Widget widget, required CustomListItem item})
      : this.item = item,
        this.widget = widget;

  final Widget widget;
  final CustomListItem item;
}

class TodoListCellSlideable extends StatelessWidgetTodoCellWrap {
  TodoListCellSlideable({required Widget widget, required CustomListItem item})
      : super(item: item, widget: widget);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: widget,
      endActionPane: ActionPane(
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              context.read<Todos>().removeItem(item);
              showCustomSnack(context, context.read<Todos>().resetData,
                  AppLocalizations.of(context)!.deletedTodo);
            },
            backgroundColor: Color(0xFFFE4A49),
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              showModal(context, 'Edit', context.read<Todos>().editItem(item),
                  item.text);
            },
            backgroundColor: Colors.blue,
            icon: Icons.edit,
          ),
        ],
        motion: BehindMotion(),
      ),
    );
  }
}
