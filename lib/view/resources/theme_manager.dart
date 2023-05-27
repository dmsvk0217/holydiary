import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.background,
    // fontFamily: 'Georgia',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.background,
      elevation: 0,
      titleTextStyle: getRegularStyle(
        color: ColorManager.text,
        fontSize: FontSize.s20,
      ),
    ),
    // textTheme: TextTheme(
    //   displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //   titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //   bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    // ),
  );
}
