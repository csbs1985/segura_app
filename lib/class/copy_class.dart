import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segura_app/class/toast_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/theme/ui_duration.dart';

class CopyClass {
  final ToastClass _toastClass = ToastClass();

  void copy({
    required BuildContext context,
    required String text,
    String? mensagem,
    bool voltar = false,
  }) {
    if (text != "") {
      Clipboard.setData(ClipboardData(text: text));
      _toastClass.sucesso(
        context: context,
        text: mensagem ?? COPY_NOTE,
      );
      Future.delayed(const Duration(milliseconds: UiDuration.toast), () {
        if (voltar) Navigator.of(context).pop();
      });
    } else {
      _toastClass.erro(
        context: context,
        text: COPY_ERROR,
      );
    }
  }
}
