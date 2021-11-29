import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomListItem {
  String text;
  bool isSelected;
  CustomListItem(this.text, this.isSelected);

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
  TodosList _tempData = [];
  TodosList getData() => _data;

  Todos() {
    _processPersistence();
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
    _data = [
      ...newData.map((el) => CustomListItem(el["text"], el["isSelected"]))
    ];
    notifyListeners();
  }

  void resetData() {
    _data = _tempData;
    _tempData = [];
    notifyListeners();
    _persist();
  }

  int getSelectedLength() {
    return this._data.where((element) => element.isSelected).length;
  }

  void addItem(String listItemText) {
    _data.add(CustomListItem(listItemText, false));
    notifyListeners();
    _persist();
  }

  void editItem(CustomListItem listItem, String listItemText) {
    listItem.text = listItemText;
    notifyListeners();
    _persist();
  }

  void removeItem(CustomListItem listItem) {
    _tempData = [..._data];
    _data.remove(listItem);
    notifyListeners();
    _persist();
  }

  void removeSelected() {
    _tempData = [..._data];
    _data.removeWhere((element) => element.isSelected);
    notifyListeners();
    _persist();
  }

  void clear() {
    _data = [];
    _tempData = [];
    notifyListeners();
    _persist();
  }

  void changeIsSelected(CustomListItem listItem, bool _isSelected) {
    listItem.isSelected = _isSelected;
    notifyListeners();
    _persist();
  }
}
