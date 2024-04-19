// ignore_for_file: prefer_conditional_assignment

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

//to load notes

  //to save notes
  static saveNote(String key, String value) {
    return _sharedPreferences!.setString(key, value);
  }

  //to get notes
  static getNote(String key) {
    return _sharedPreferences!.getString(key);
  }

  //to delete note
  static deleteNote(int index) {}

  //to update note
}
