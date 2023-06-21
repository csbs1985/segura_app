import 'package:flutter/material.dart';
import 'package:m_toast/m_toast.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_duracao.dart';

class ToastClass {
  ShowMToast toast = ShowMToast();

  void erro({
    required BuildContext context,
    required String texto,
  }) {
    toast.errorToast(
      context,
      message: texto,
      iconColor: UiCor.toastElemento,
      textColor: UiCor.toastElemento,
      backgroundColor: UiCor.erro,
      alignment: Alignment.topCenter,
      duration: UiDuracao.toast,
      width: double.infinity,
    );
  }

  void sucesso({
    required BuildContext context,
    required String texto,
  }) {
    toast.successToast(
      context,
      message: texto,
      iconColor: UiCor.toastElemento,
      textColor: UiCor.toastElemento,
      backgroundColor: UiCor.sucesso,
      alignment: Alignment.topCenter,
      duration: UiDuracao.toast,
      width: double.infinity,
    );
  }
}
