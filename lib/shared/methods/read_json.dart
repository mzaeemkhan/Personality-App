import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:personality_test/models/data_model.dart';

Future<DataModel> readJson() async {
  final String response =
      await rootBundle.loadString("assets/data/json/mbti_json.json");
  var data = await json.decode(response);
  DataModel result = DataModel.fromJson(data);
  return result;
}
