import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';

class CopiarClass {
  final ToastClass _toastClass = ToastClass();

  void copiar(BuildContext context, String texto) {
    if (texto.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: texto));
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.SUCESSO.value,
        texto: COPIAR_COPIADO,
      );
      Navigator.of(context).pop();
    } else {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: COPIAR_ERRO,
      );
    }
  }
}
