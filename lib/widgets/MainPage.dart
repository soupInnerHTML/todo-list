import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Settings.dart';
import 'package:flutter_application_1/models/Todos.dart';
import 'package:flutter_application_1/widgets/EmptyData.dart';
import 'package:flutter_application_1/widgets/TodoList/TodoList.dart';
import 'package:flutter_application_1/widgets/fns/showModal.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();
    final primarySwatch = settings.primarySwatch;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch,
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        brightness: Brightness.dark, //white icons in status bar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Visibility(
                child: EmptyData(),
                visible: context.watch<Todos>().getData().isEmpty,
              ),
              TodoList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModal(context, 'Add', context.read<Todos>().addItem);
        },
        backgroundColor: primarySwatch,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
        color: primarySwatch,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: settings.fabLocation,
    );
  }
}
