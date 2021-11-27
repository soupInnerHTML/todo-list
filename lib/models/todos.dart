import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomListItem {
  String text;
  bool isSelected;
  CustomListItem(this.text, this.isSelected);
  // CustomListItem.fromJson(Map<String, dynamic> json)
  //     : text = json['text'],
  //       isSelected = json['isSelected'];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSelected': isSelected,
    };
  }
}

class Todos with ChangeNotifier {
  List<CustomListItem> _data = [];
  List<CustomListItem> _tempData = [];
  List<CustomListItem> getData() => _data;

  // @override
  // void addListener(VoidCallback listener) {
  //   notifyListeners();
  //   print('__listener__');
  // }

  Todos() {
    _processPersistence();
  }

  void _persist() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', jsonEncode(_data));
  }

  void _processPersistence() async {
    final prefs = await SharedPreferences.getInstance();
    final todos = prefs.getString('todos');
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
