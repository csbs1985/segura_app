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

  getSenhaId(String idSenha) async {
    await _senhaFirestore.getSenhaId(idSenha).then((result) => {
          result != null,
        });
  }

  postSenha(Map<String, dynamic> senha) async {
    await _senhaFirestore.postSenha(senha);
  }

  String gerarSenha(
    List<GerarSenhaModel> listaSelecionado,
    int tamanho,
  ) {
    const letrasMaiusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const letrasMinusculas = 'abcdefghijklmnopqrstuvwxyz';
    const numeros = '0123456789';
    const caracteresEspeciais = '!@#\$%^&*()-_=+[]{}|;:,.<>/?';

    final random = Random();
    String caracteresPermitidos = '';

    if (listaSelecionado[0].selecionado)
      caracteresPermitidos += letrasMinusculas;
    if (listaSelecionado[1].selecionado)
      caracteresPermitidos += letrasMaiusculas;
    if (listaSelecionado[2].selecionado) caracteresPermitidos += numeros;
    if (listaSelecionado[3].selecionado)
      caracteresPermitidos += caracteresEspeciais;

    String senha = '';
    for (int i = 0; i < tamanho; i++) {
      int indice = random.nextInt(caracteresPermitidos.length);
      senha += caracteresPermitidos[indice];
    }

    return senha;
  }

  deletarSenha(BuildContext context, String idSenha) {
    try {
      _senhaFirestore.deletarSenhaId(idSenha).then(
            (result) => Navigator.of(context).pop(),
          );
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: SENHA_DELETAR_ERRO,
      );
    }
  }
}
