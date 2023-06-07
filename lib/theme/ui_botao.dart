import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';

class UiBotao {
  static ButtonStyle tag = ButtonStyle(
    padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.fromLTRB(16, 0, 16, 0)),
    backgroundColor: const MaterialStatePropertyAll<Color>(UiCor.tag),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );

  static ButtonStyle tagAtivo = ButtonStyle(
    padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.fromLTRB(16, 0, 16, 0)),
    backgroundColor: const MaterialStatePropertyAll<Color>(UiCor.tagAtivo),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );

  static ButtonStyle tagEscuro = ButtonStyle(
    padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.fromLTRB(16, 0, 16, 0)),
    backgroundColor: const MaterialStatePropertyAll<Color>(UiCor.tagEscuro),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );
}
