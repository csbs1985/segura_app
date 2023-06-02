import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/theme/ui_cor.dart';

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
        statusBarColor: isEscuro ? UiCor.principalEscuro : UiCor.principal,
        systemNavigationBarIconBrightness:
            isEscuro ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
      ),
    );

    ThemeData();
  }

  static ThemeData tema = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: UiCor.principal,
      elevation: 0,
    ),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: UiCor.principal),
    fontFamily: 'nunito',
    scaffoldBackgroundColor: UiCor.principal,
    textTheme: const TextTheme(),
  );

  static ThemeData temaEscuro = ThemeData(
    scaffoldBackgroundColor: UiCor.principalEscuro,
    fontFamily: 'nunito',
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: UiCor.principalEscuro),
    textTheme: const TextTheme(),
  );
}
