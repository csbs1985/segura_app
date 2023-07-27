import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_texto.dart';

class UiTema {
  static definirTema() {
    currentTema.value =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    trocarTema();
  }

  static trocarTema() {
    bool isEscuro = currentTema.value == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isEscuro ? Brightness.light : Brightness.dark,
        statusBarBrightness: isEscuro ? Brightness.light : Brightness.dark,
        statusBarColor: isEscuro ? UiCor.statusBarEscura : UiCor.statusBar,
        systemNavigationBarIconBrightness:
            isEscuro ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            isEscuro ? UiCor.navigationBarEscura : UiCor.navigationBar,
      ),
    );

    ThemeData();
  }

  static ThemeData tema = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.appBar,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: UiCor.icon),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: UiCor.input,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: UiCor.segunda,
      elevation: 0,
    ),
    scaffoldBackgroundColor: UiCor.background,
    textTheme: const TextTheme(
      displayLarge: UiTextClaro.headline1,
      displayMedium: UiTextClaro.headline2,
      displaySmall: UiTextClaro.headline3,
      bodySmall: UiTextClaro.hintInput,
      labelSmall: UiTextClaro.headline4,
      labelLarge: UiTextClaro.botao,
    ),
  );

  static ThemeData temaEscuro = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.backgroundEscuro,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: UiCor.iconEscuro),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: UiCor.inputEscuro,
    ),
    scaffoldBackgroundColor: UiCor.backgroundEscuro,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: UiCor.segunda,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayLarge: UiTextEscuro.headline1,
      displayMedium: UiTextEscuro.headline2,
      displaySmall: UiTextEscuro.headline3,
      bodySmall: UiTextEscuro.hintInput,
      labelSmall: UiTextEscuro.headline4,
      labelLarge: UiTextEscuro.botao,
    ),
  );
}
