import 'package:flutter/material.dart';
import 'package:full_stack_project/core/theme/app_pallete.dart';


class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
     borderSide: BorderSide(
            color: color,
            width:3,
          ),
          borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(22),
        enabledBorder: _border(Pallete.borderColor),
        focusedBorder: _border(Pallete.gradient2),
    ),
  );

}