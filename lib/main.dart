// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/App.dart';
import 'package:flutter_application_1/models/Settings.dart' as SettingsProvider;
import 'package:provider/provider.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Todos>(create: (_) => Todos()),
        ChangeNotifierProvider<SettingsProvider.Settings>(
            create: (_) => SettingsProvider.Settings()),
      ],
      child: App(),
    );
  }
}
