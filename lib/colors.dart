import 'package:flutter/material.dart';

Color colorFromHex(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class MyColors {
  static Color extraLightRed = colorFromHex('#EA6564');
  static Color lightRed = colorFromHex('#E43a39');
  static Color darkRed = colorFromHex('#811111');
  static Color lightBlue = colorFromHex('#ADD8E6');
  static Color darkBlue = colorFromHex('#004369');
  static Color dark = colorFromHex('#2F2440');
  static Color darkBackground = colorFromHex('#282c34');
  static Color darkBackgroundTranslucent = Color.fromRGBO(0, 0, 0, 0.9);
  static Color darkerBackground = colorFromHex('#14161a');
  static Color darkerTranslucentBackground = Color.fromRGBO(20, 22, 26, .9);
  static Color lightBackground = Color.fromRGBO(255, 255, 242, 1);
  static Color gold = colorFromHex('#FFD700');
  static Color lightGreen = colorFromHex('#90EE90');
  static Color gray = colorFromHex('#808080');
  static Color lightGray = colorFromHex('#D3D3D3');
}
