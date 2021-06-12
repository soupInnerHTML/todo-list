import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/MainPage.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TODO App',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: MainPage());
  }
}
