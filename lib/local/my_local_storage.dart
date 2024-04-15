import 'dart:convert';

import 'package:personality_test/models/test_history_model.dart';
import 'package:personality_test/shared/resources/string_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocalStorage {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> init() async {
    _prefs ??= await SharedPreferences.getInstance();

    return _prefs!;
  }

  static Future setBool(String key, bool val) async {
    await _prefs!.setBool(key, val);
  }

  static Future<bool> getBool(String key) async {
    bool boolValue = false;
    if (_prefs!.containsKey(key)) {
      boolValue = _prefs!.getBool(key) ?? false;
    }
    return boolValue;
  }

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);

  static String getString(String key) {
    String value = "";
    try {
      if (_prefs!.containsKey(key)) {
        value = _prefs!.getString(key) ?? "";
      } else {
        value = "";
      }
    } catch (exception) {
      value = "";
    }

    return value;
  }

  static Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);

  static int getInt(String key) {
    int value = -1;
    try {
      if (_prefs!.containsKey(key)) {
        value = _prefs!.getInt(key) ?? -1;
      } else {
        value = -1;
      }
    } catch (exception) {
      value = -1;
    }

    return value;
  }

  static setTestHistory(List<TestHistoryModel> questionHistoryList) async {
    _prefs!.setString(
        StringAssets.keyTestHistory, jsonEncode(questionHistoryList));
  }

  static Future<List<TestHistoryModel>> getTestHistory() async {
    List<TestHistoryModel> dataList = List.empty(growable: true);
    if (_prefs!.containsKey(StringAssets.keyTestHistory)) {
      // Read the data, decode it and store it in QuestionHistoryModel structure
      final List<dynamic> jsonData =
          jsonDecode(_prefs!.getString(StringAssets.keyTestHistory) ?? '[]');
      dataList = jsonData.map<TestHistoryModel>((jsonItem) {
        return TestHistoryModel.fromJson(jsonItem);
      }).toList();
    }

    return dataList;
  }

  static Future<bool> remove(String key) async => await _prefs!.remove(key);

  static Future<bool> clear() async => await _prefs!.clear();
}
