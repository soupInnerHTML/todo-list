import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomListItem {
  String text;

  bool isSelected;
  CustomListItem(this.text, {this.isSelected = false});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSelected': isSelected,
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
        .map((el) => CustomListItem(el["text"], isSelected: el["isSelected"]))
        .toList();
    notifyListeners();
  }

  void resetData() {
    data = _tempData;
    _tempData = [];
  }

  get selectedLength {
    return this._data.where((element) => element.isSelected).length;
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
              isSelected: element.isSelected))
          .toList();
    };
  }

  void removeItem(CustomListItem listItem) {
    data =
        data.where((element) => element.hashCode != listItem.hashCode).toList();
  }

  void removeSelected() {
    data = data.where((element) => !element.isSelected).toList();
  }

  void changeIsSelected(CustomListItem listItem, bool isSelected) {
    data = data
        .map((element) => CustomListItem(element.text,
            isSelected: element.hashCode == listItem.hashCode
                ? isSelected
                : element.isSelected))
        .toList();
  }

  void selectAll(bool isSelected) {
    data = data
        .map((element) => CustomListItem(element.text, isSelected: isSelected))
        .toList();
  }
}
