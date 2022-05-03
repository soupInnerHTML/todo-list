import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/fns/showCustomDialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodoListColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Todos todos = context.read<Todos>();
    final l = AppLocalizations.of(context)!; //localization

    return Visibility(
      visible: todos.selectedLength > 0,
      child: Row(
        children: [
          Text(
            '${todos.selectedLength}/${todos.data.length}',
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
                text: l.yes,
              );

              Config cancelConfig = Config(
                callback: () => Navigator.pop(context),
                text: l.no,
              );

              showCustomDialog(
                context,
                l.areYouSure,
                todos.selectedLength > 1 ? l.deleteTodos : l.deleteTodo,
                submitConfig,
                cancelConfig,
              );
            },
          ),
        ],
      ),
    );
  }
}
