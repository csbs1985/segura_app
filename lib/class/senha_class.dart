import 'dart:math';
import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';

class SenhaClass {
  final SenhaFirestore _senhaFirestore = SenhaFirestore();
  final ToastClass _toastClass = ToastClass();

  Future<String> definirFavicon(String url) async {
    final favicon = await FaviconFinder.getBest(url);
    return favicon!.url;
  }

  String ultimaAlteracaoSenha(String data) {
    final DateTime registro = DateTime.parse(data);
    final DateTime hoje = DateTime.now();
    final difference = registro.difference(hoje);
    final diferenca = difference.inDays.abs();

    if (diferenca <= 0) return HOJE;
    return "$SENHA_ALTERACAO_1 $diferenca $SENHA_ALTERACAO_2";
  }

  String ultimaEdicao(String value) {
    DateTime data = DateTime.parse(value);
    DateTime agora = DateTime.now();
    Duration diferenca = agora.difference(data);

    if (diferenca.inMinutes < 1) {
      return "editado agora";
    } else if (diferenca.inHours < 1) {
      return "editado há menos de uma hora";
    } else if (diferenca.inHours < 24) {
      return "editado há ${diferenca.inHours} hora(s)";
    } else if (diferenca.inDays < 7) {
      initializeDateFormatting();
      String diaSemana = DateFormat('EEEE', 'pt_BR').format(data);
      return "editado $diaSemana";
    } else {
      String dataFormatada = DateFormat('d MMM yyyy', 'pt_BR').format(data);
      return "editado $dataFormatada";
    }
  }

  postSenha(Map<String, dynamic> senha) async {
    await _senhaFirestore.postSenha(senha);
  }

  String gerarSenha(
    List<String> listaSelecionado,
    int tamanho,
  ) {
    const caracteres = '!@#\$%^&*()-_=+[]{}|;:,.<>/?';
    const maiuscula = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const minuscula = 'abcdefghijklmnopqrstuvwxyz';
    const numeros = '0123456789';

    final random = Random();
    String caracteresPermitidos = '';

    if (listaSelecionado.contains(GerarSenhaEnum.CARACTERES.value))
      caracteresPermitidos += caracteres;
    if (listaSelecionado.contains(GerarSenhaEnum.MAIUSCULA.value))
      caracteresPermitidos += maiuscula;
    if (listaSelecionado.contains(GerarSenhaEnum.MINUSCULA.value))
      caracteresPermitidos += minuscula;
    if (listaSelecionado.contains(GerarSenhaEnum.NUMEROS.value))
      caracteresPermitidos += numeros;

    String senha = '';
    for (int i = 0; i < tamanho; i++) {
      int indice = random.nextInt(caracteresPermitidos.length);
      senha += caracteresPermitidos[indice];
    }

    return senha;
  }

  deletarSenha(BuildContext context, String idSenha) {
    try {
      _senhaFirestore
          .patchDeletarSenhaId(idSenha)
          .then((result) => Navigator.of(context).pop());
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: SENHA_DELETAR_ERRO,
      );
    }
  }

  deletarSenhaDefinitivo(BuildContext context, String idSenha) {
    try {
      _senhaFirestore
          .deletarSenhaId(idSenha)
          .then((result) => Navigator.of(context).pop());
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: SENHA_DELETAR_ERRO,
      );
    }
  }
}
