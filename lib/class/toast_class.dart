import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:toastification/toastification.dart';
import 'package:unicons/unicons.dart';

class ToastClass {
  void abrirToast({
    required BuildContext context,
    required String estilo,
    required String texto,
    int? duracao,
  }) {
    toastification.show(
      context: context,
      autoCloseDuration: Duration(seconds: duracao ?? 2),
      title: texto,
      animationDuration: const Duration(milliseconds: 300),
      icon: definirIcone(estilo),
      backgroundColor: definirCor(estilo),
      foregroundColor: UiCor.textoEscuro,
      brightness: Brightness.light,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      showProgressBar: true,
      closeOnClick: true,
    );
  }

  Color definirCor(String estilo) {
    if (estilo == SenhaEnum.ERRO.value) return UiCor.erro;
    if (estilo == SenhaEnum.PADRAO.value) return UiCor.segunda;
    return UiCor.sucesso;
  }

  Widget definirIcone(String estilo) {
    if (estilo == SenhaEnum.ERRO.value) return const Icon(UniconsLine.angry);
    if (estilo == SenhaEnum.PADRAO.value) return const Icon(UniconsLine.squint);
    return const Icon(UniconsLine.meh_closed_eye);
  }
}

enum SenhaEnum {
  ERRO('up_notification'),
  PADRAO('up_biography'),
  SUCESSO('unblock_user');

  final String value;
  const SenhaEnum(this.value);
}
