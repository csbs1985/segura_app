import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';

class CopiarClass {
  final ToastClass _toastClass = ToastClass();

  void copiar({
    required BuildContext context,
    required String texto,
    bool? voltar,
  }) {
    if (texto != "") {
      Clipboard.setData(ClipboardData(text: texto));
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.SUCESSO.value,
        texto: COPIAR_COPIADO,
      );
      if (voltar!) Navigator.of(context).pop();
    } else {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: COPIAR_ERRO,
      );
    }
  }
}
