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
    color: UiCor.textEscuro,
  );
  static const TextStyle tagEscuro = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: UiCor.textEscuro,
  );
}

class UiTextClaro {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: UiCor.text,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: UiCor.text,
  );
  static const TextStyle headline3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: UiCor.text,
  );
  static const TextStyle headline4 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: UiCor.text,
    letterSpacing: 0,
  );
  static const TextStyle botao = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: UiCor.textoButton,
  );
  static const TextStyle hintInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: UiCor.hintText,
  );
}

class UiTextEscuro {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: UiCor.textEscuro,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: UiCor.textEscuro,
  );
  static const TextStyle headline3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: UiCor.textEscuro,
  );
  static const TextStyle headline4 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: UiCor.textEscuro,
    letterSpacing: 0,
  );
  static const TextStyle botao = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: UiCor.textoButtonEscuro,
  );
  static const TextStyle hintInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: UiCor.hintTextEscuro,
  );
}
