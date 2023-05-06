import 'package:flutter/material.dart';

import '../style/borders.dart';
import '../style/colors.dart';
import '../style/paddings.dart';

/// all custom application theme
class AppTheme {
  /// default application theme
  static ThemeData get basic => ThemeData(
      canvasColor: kBackgroundColor,
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: kBackgroundColor,
      inputDecorationTheme: inputDecorationTheme());

  // you can add other custom theme in this class like  light theme, dark theme ,etc.

  // example :
  // static ThemeData get light => ThemeData();
  // static ThemeData get dark => ThemeData();

}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    focusColor: kPrimaryColor,
    fillColor: kBoxColor,
    filled: true,
    contentPadding: const EdgeInsets.all(kContentPadding),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: kInputBorderColor,
        ),
        borderRadius: BorderRadius.circular(kInputBorder),
        ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kInputBorder),
        borderSide: const BorderSide(color: kPrimaryColor),
        ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kInputBorder),
        borderSide: const BorderSide(color: kErrorColor),
        ),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kInputBorder),
        borderSide: const BorderSide(color: kErrorColor),
        ),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kInputBorder),
        borderSide: const BorderSide(color: kInputBorderColor),
        ),
  );
}
