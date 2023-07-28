import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_text.dart';

class UiTheme {
  static definirTema() {
    currentTheme.value =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    trocarTema();
  }

  static trocarTema() {
    bool isDark = currentTheme.value == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarColor: isDark ? UiColor.statusBarDark : UiColor.statusBar,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            isDark ? UiColor.navigationBarDark : UiColor.navigationBar,
      ),
    );

    ThemeData();
  }

  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: UiColor.back,
    textTheme: const TextTheme(
      bodyLarge: UiText.bodyLarge,
      bodyMedium: UiText.bodyMedium,
    ),
  );

  static ThemeData themeDark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: UiColor.backDark,
    textTheme: const TextTheme(
      bodyLarge: UiTextDark.bodyLarge,
      bodyMedium: UiTextDark.bodyMedium,
    ),
  );
}
