import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/createMaterialColor.dart';

class Settings with ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  MaterialColor _primarySwatch = Colors.deepPurple;
  MaterialColor get primarySwatch => _primarySwatch;
  set primarySwatch(MaterialColor newValue) {
    _primarySwatch = newValue;
    notifyListeners();
    _persist("primarySwatch", _primarySwatch.value.toString());
  }

  Brightness _theme = Brightness.light;
  Brightness get theme => _theme;
  set theme(Brightness newValue) {
    _theme = newValue;
    notifyListeners();
    _persist("theme", _theme.toString());
  }

  Locale? _locale;
  Locale? get locale => _locale;
  set locale(Locale? newValue) {
    _locale = newValue;
    notifyListeners();
    if (_locale != null) {
      _persist("locale", _locale!.languageCode);
    } else {
      _sharedPreferences.remove("locale");
    }
  }

  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.centerDocked;
  FloatingActionButtonLocation get fabLocation => _fabLocation;
  set fabLocation(FloatingActionButtonLocation newValue) {
    _fabLocation = newValue;
    notifyListeners();
    _persist("fabLocation", fabLocationParsed);
  }

  String get fabLocationParsed {
    switch (fabLocation) {
      case FloatingActionButtonLocation.centerDocked:
        return "Center";
      case FloatingActionButtonLocation.startDocked:
        return "Left";
      case FloatingActionButtonLocation.endDocked:
        return "Right";
      default:
        return "Center";
    }
  }

  FloatingActionButtonLocation getFabLocationFromString(String? fabLocation) {
    switch (fabLocation) {
      case "Center":
        return FloatingActionButtonLocation.centerDocked;
      case "Left":
        return FloatingActionButtonLocation.startDocked;
      case "Right":
        return FloatingActionButtonLocation.endDocked;
      default:
        return FloatingActionButtonLocation.centerDocked;
    }
  }

  bool _removeCompletedTodo = false;
  bool get removeCompletedTodo => _removeCompletedTodo;
  set removeCompletedTodo(bool newValue) {
    _removeCompletedTodo = newValue;
    notifyListeners();
    _sharedPreferences.setBool('isRemoveCompletedTodo', newValue);
  }

  void _persist(String name, String value) {
    _sharedPreferences.setString(name, value);
  }

  void _processPersistence() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    String? theme = _sharedPreferences.getString("theme");
    String? primarySwatch = _sharedPreferences.getString("primarySwatch");
    String? locale = _sharedPreferences.getString("locale");
    String? fabLocation = _sharedPreferences.getString("fabLocation");
    bool? removeCompletedTodo =
        _sharedPreferences.getBool("isRemoveCompletedTodo");

    if (theme != null) {
      this.theme = EnumToString.fromString(
          Brightness.values, theme.replaceAll(RegExp(r'\w+\.'), ""))!;
    } else {
      this.theme = SchedulerBinding.instance!.window.platformBrightness;
    }

    if (primarySwatch != null) {
      this.primarySwatch = createMaterialColor(primarySwatch);
    }

    if (locale != null) {
      this.locale = Locale(locale);
    }

    if (removeCompletedTodo != null) {
      this.removeCompletedTodo = removeCompletedTodo;
    }

    this.fabLocation = getFabLocationFromString(fabLocation);
  }

  Settings() {
    _processPersistence();
  }
}
