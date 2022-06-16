import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomListItem {
  String text;

  bool isDone;
  bool willDie;
  CustomListItem(this.text, {this.isDone = false, this.willDie = false});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isDone': isDone,
    };
  }
}

typedef TodosList = List<CustomListItem>;

class Todos with ChangeNotifier {
  TodosList _data = [];

  TodosList get data => _data;
  set data(TodosList newVal) {
    _tempData = [...data];
    _data = newVal;
    notifyListeners();
    _persist();
  }

  TodosList _tempData = [];
  TodosList getData() => data;

  Todos() {
    _processPersistence();
  }
  void operator +(String listItemText) {
    addItem(listItemText);
  }

  void _persist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', jsonEncode(_data));
  }

  void _processPersistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todos = prefs.getString('todos');

    if (todos != null) {
      _setData(jsonDecode(todos));
    }
  }

  void _setData(List<dynamic> newData) {
    _data = newData
        .map((el) => CustomListItem(el["text"], isDone: el["isDone"]))
        .toList();
    notifyListeners();
  }

  void resetData() {
    data = _tempData;
    _tempData = [];
  }

  get selectedLength {
    return this._data.where((element) => element.isDone).length;
  }

  void addItem(String listItemText) {
    data = [...data, CustomListItem(listItemText)];
  }

  Function(String) editItem(CustomListItem listItem) {
    return (String listItemText) {
      data = data
          .map((element) => CustomListItem(
              listItem.hashCode == element.hashCode
                  ? listItemText
                  : element.text,
              isDone: element.isDone))
          .toList();
    };
  }

  void removeItem(CustomListItem listItem) {
    data =
        data.where((element) => element.hashCode != listItem.hashCode).toList();
  }

  void removeCompleted() {
    data = data.where((element) => !element.isDone).toList();
  }

  void changeIsDone(CustomListItem listItem, bool isDone) {
    data = data
        .map((element) => CustomListItem(element.text,
            isDone: element.hashCode == listItem.hashCode
                ? isDone
                : element.isDone))
        .toList();
  }

  void selectAll(bool isSelected) {
    data = data
        .map((element) => CustomListItem(element.text, isDone: isSelected))
        .toList();
  }
}
