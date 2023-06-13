import 'package:flutter/cupertino.dart';
import 'package:senha_app/theme/ui_cor.dart';

class UiTexto {
  static const TextStyle erro = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: UiCor.erro,
  );
  static const TextStyle tag = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: UiCor.segunda,
  );
  static const TextStyle tagAtiva = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: UiCor.textoEscuro,
  );
  static const TextStyle tagEscuro = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: UiCor.textoEscuro,
  );
  static const TextStyle botao = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: UiCor.textoEscuro,
  );
  static const TextStyle hintInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: UiCor.hintTexto,
  );
}

class UiTextoClaro {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: UiCor.texto,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: UiCor.texto,
  );
  static const TextStyle headline3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: UiCor.texto,
  );
  static const TextStyle headline4 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: 'nunito',
    color: UiCor.texto,
    letterSpacing: 0,
  );
}

class UiTextoEscuro {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: UiCor.textoEscuro,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: UiCor.textoEscuro,
  );
  static const TextStyle headline3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: UiCor.textoEscuro,
  );
  static const TextStyle headline4 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: UiCor.textoEscuro,
    fontFamily: 'nunito',
    letterSpacing: 0,
  );
}
