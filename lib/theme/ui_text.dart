import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_color.dart';

class UiText {
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: UiColor.text,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: UiColor.text,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: UiColor.text,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: UiColor.primary,
  );
}

class UiTextDark {
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: UiColor.textDark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: UiColor.textDark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: UiColor.textDark,
  );
}
