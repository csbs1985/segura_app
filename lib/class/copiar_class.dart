import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/theme/ui_duracao.dart';

class CopiarClass {
  final ToastClass _toastClass = ToastClass();

  void copiar({
    required BuildContext context,
    required String texto,
    bool voltar = false,
  }) {
    if (texto != "") {
      Clipboard.setData(ClipboardData(text: texto));
      _toastClass.sucesso(
        context: context,
        texto: COPIAR_COPIADO,
      );
      Future.delayed(const Duration(milliseconds: UiDuracao.toast), () {
        if (voltar) Navigator.of(context).pop();
      });
    } else {
      _toastClass.erro(
        context: context,
        texto: COPIAR_ERRO,
      );
    }
  }
}
