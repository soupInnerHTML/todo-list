import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todos.dart';
import 'package:flutter_application_1/widgets/EmptyData.dart';
import 'package:flutter_application_1/widgets/TodoList.dart';
import 'package:flutter_application_1/widgets/fns/showModal.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        brightness: Brightness.dark, //white icons in status bar
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Visibility(
            child: EmptyData(),
            visible: context.watch<Todos>().getData().isEmpty,
          ),
          TodoList(),
        ])),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModal(context, 'Add', context.read<Todos>().addItem);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
        color: Colors.deepPurple,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
