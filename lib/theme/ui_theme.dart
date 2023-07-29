import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_text.dart';

class UiTheme {
  static setTheme() {
    currentTheme.value =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    changeTheme();
  }

  static changeTheme() {
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
  }

  static ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(elevation: 0),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      onBackground: UiColor.skeleton,
      outline: UiColor.border,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: UiColor.input,
      prefixIconColor: UiColor.icon,
    ),
    primaryColor: UiColor.primary,
    scaffoldBackgroundColor: UiColor.back,
    textTheme: const TextTheme(
      bodyLarge: UiText.bodyLarge,
      bodyMedium: UiText.bodyMedium,
      bodySmall: UiText.bodySmall,
      displayMedium: UiText.displayMedium,
      displaySmall: UiText.displaySmall,
    ),
  );

  static ThemeData themeDark = ThemeData(
    appBarTheme: const AppBarTheme(elevation: 0),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      onBackground: UiColor.skeletonDark,
      outline: UiColor.borderDark,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: UiColor.inputDark,
      prefixIconColor: UiColor.iconDark,
    ),
    primaryColor: UiColor.primary,
    scaffoldBackgroundColor: UiColor.backDark,
    textTheme: const TextTheme(
      bodyLarge: UiTextDark.bodyLarge,
      bodyMedium: UiTextDark.bodyMedium,
      bodySmall: UiTextDark.bodySmall,
      displayMedium: UiText.displayMedium,
      displaySmall: UiText.displaySmall,
    ),
  );
}
