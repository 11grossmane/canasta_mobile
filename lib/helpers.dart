import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double screenWidth;

Future<String> _loadFromAsset(String path) async {
  return await rootBundle.loadString(path);
}

Future parseJson(String path) async {
  String jsonString = await _loadFromAsset(path);
  final jsonResponse = jsonDecode(jsonString);
  return jsonResponse;
}

List<T> shuffle<T>(List<T> list) {
  var copy = list;
  copy.shuffle();
  return copy;
}

RenderBox getRenderBox(GlobalKey key) {
  if (key == null) return null;
  RenderBox renderBox = key.currentContext.findRenderObject();
  return renderBox;
}

class Bounds {
  double left;
  double right;
  Bounds({@required left, @required right});
}

Map<int, Bounds> getBoundsByIndex(List<String> ids, double containerWidth) {
  Map<int, Bounds> res = {};
  var sectionSize = containerWidth / ids.length;
  for (var i = 0; i < ids.length; i++) {
    res[i] =
        Bounds(left: sectionSize * i, right: sectionSize * i + sectionSize);
  }
  return res;
}

int getEndIndex(
    {@required double width,
    @required int lengthOfList,
    @required double offsetX,
    @required double containerStart,
    double containerEnd}) {
  var sectionSize = width / lengthOfList;
  print('inside getEndIndex offsetX $offsetX sectionSize $sectionSize');
  var floor = ((offsetX - containerStart) / sectionSize).floor();
  return floor > lengthOfList - 1
      ? lengthOfList - 1
      : floor < 0
          ? 0
          : floor;
}
