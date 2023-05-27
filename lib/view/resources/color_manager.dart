import 'package:flutter/material.dart';

class ColorManager {
  static Color navIcon = HexColor.fromHex("#E6E1E5");
  static Color navIconActive = HexColor.fromHex("#D0BCFF");
  static Color background = HexColor.fromHex("#1E1E1E");
  static Color navBackground = HexColor.fromHex("#2A2830");
  static Color appbarBackground = HexColor.fromHex("#2A2830");
  static Color textfield = HexColor.fromHex("#2F2D37");
  static Color text = HexColor.fromHex("##C9C4CF");
  static Color calenderActive = HexColor.fromHex("#CDBDFA");
  static Color calenderActivetext = HexColor.fromHex("#341F6E");

  static Color primary = HexColor.fromHex("##C9C4CF");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
