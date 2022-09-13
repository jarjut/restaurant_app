import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get mainTheme {
  final baseTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  final textTheme = GoogleFonts.latoTextTheme(baseTheme.textTheme);

  return baseTheme.copyWith(
    textTheme: textTheme.copyWith(
      titleSmall: textTheme.titleSmall?.copyWith(
        color: Colors.grey,
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade600,
      ),
    ),
  );
}
