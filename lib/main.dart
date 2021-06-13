// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todos.dart';
import 'package:flutter_application_1/widgets/MainPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Todos>(
      create: (context) => Todos(),
      child: MaterialApp(
          title: 'TODO App',
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          home: MainPage()),
    );
  }
}
