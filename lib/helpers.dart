import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> _loadFromAsset(String path) async {
  return await rootBundle.loadString(path);
}

Future parseJson(String path) async {
  String jsonString = await _loadFromAsset(path);
  final jsonResponse = jsonDecode(jsonString);
  return jsonResponse;
}
