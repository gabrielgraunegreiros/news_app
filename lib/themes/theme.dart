import 'package:flutter/material.dart';

final miTema = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.red),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
  dividerColor: Colors.white
);
