import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_texto.dart';

ValueNotifier<Brightness> currentTema = ValueNotifier(
    WidgetsBinding.instance.platformDispatcher.platformBrightness);

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
        statusBarColor: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
        systemNavigationBarIconBrightness:
            isEscuro ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
      ),
    );

    ThemeData();
  }

  static ThemeData tema = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.fundo,
      elevation: 0,
    ),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiCor.fundo),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: UiCor.segunda,
      elevation: 0,
    ),
    fontFamily: 'duolingo',
    scaffoldBackgroundColor: UiCor.fundo,
    textTheme: const TextTheme(
      displayLarge: UiTextoClaro.headline1,
      displayMedium: UiTextoClaro.headline2,
      displaySmall: UiTextoClaro.headline3,
      bodySmall: UiTextoClaro.hintInput,
      labelSmall: UiTextoClaro.headline4,
    ),
  );

  static ThemeData temaEscuro = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.fundoEscuro,
      elevation: 0,
    ),
    scaffoldBackgroundColor: UiCor.fundoEscuro,
    fontFamily: 'duolingo',
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiCor.fundoEscuro),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: UiCor.segunda,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displayLarge: UiTextoEscuro.headline1,
      displayMedium: UiTextoEscuro.headline2,
      displaySmall: UiTextoEscuro.headline3,
      bodySmall: UiTextoEscuro.hintInput,
      labelSmall: UiTextoEscuro.headline4,
    ),
  );
}
