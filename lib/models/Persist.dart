import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistChangeNotifier with ChangeNotifier {
  PersistChangeNotifier() {
    _processPersistence();
  }

  List<dynamic> _perisitableFields = [];

  void perisitable(dynamic field) {
    _perisitableFields.add(field);
  }

  void _persist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('todos', jsonEncode(_data));
  }

  void _processPersistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todos = prefs.getString('todos');

    if (todos != null) {
      _setData(jsonDecode(todos));
    }
  }

  void _setData(List<dynamic> newData) {
    // _data = [
    //   ...newData.map((el) => CustomListItem(el["text"], el["isSelected"]))
    // ];
    notifyListeners();
  }

  void _action() {
    notifyListeners();
    _persist();
  }
}
