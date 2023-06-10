import 'dart:math';
import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class SenhaClass {
  final SenhaFirestore _senhaFirestore = SenhaFirestore();
  final ToastClass _toastClass = ToastClass();

  Future<String> definirTitleSite(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final titleElement = document.head!.querySelector('title');

      if (titleElement != null) {
        return titleElement.text;
      }
    }

    return '';
  }

  Future<String> definirFavicon(String url) async {
    final favicon = await FaviconFinder.getBest(url);
    return favicon!.url;
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

  postSenha(BuildContext context, Map<String, dynamic> senha) async {
    try {
      await _senhaFirestore.postSenha(senha);
      Navigator.of(context).pop();
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: SENHA_SALVAR_ERRO,
      );
    }
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

    if (listaSelecionado.contains(GerarSenhaEnum.CARACTERES.name))
      caracteresPermitidos += caracteres;
    if (listaSelecionado.contains(GerarSenhaEnum.MAIUSCULA.name))
      caracteresPermitidos += maiuscula;
    if (listaSelecionado.contains(GerarSenhaEnum.MINUSCULA.name))
      caracteresPermitidos += minuscula;
    if (listaSelecionado.contains(GerarSenhaEnum.NUMEROS.name))
      caracteresPermitidos += numeros;

    String senha = '';
    for (int i = 0; i < tamanho; i++) {
      int indice = random.nextInt(caracteresPermitidos.length);
      senha += caracteresPermitidos[indice];
    }

    return senha;
  }

  toggleSenhaTrue(BuildContext context, String idSenha) async {
    try {
      await _senhaFirestore.toggleSenhaTrue(idSenha);
      Navigator.of(context).pop();
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: SENHA_DELETAR_ERRO,
      );
    }
  }

  excluirSenha(BuildContext context, String idSenha) async {
    try {
      await _senhaFirestore.deleteSenhaId(idSenha);
      Navigator.of(context).pop();
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: SENHA_DELETAR_ERRO,
      );
    }
  }

  esvaziarLixeira(BuildContext context, List<String> listaSenha) async {
    try {
      for (var item in listaSenha) await _senhaFirestore.deleteSenhaId(item);
      Navigator.of(context).pop();
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: SENHA_DELETAR_ERRO,
      );
    }
  }

  toggleSenhaFalse(BuildContext context, String idSenha) async {
    try {
      await _senhaFirestore.toggleSenhaFalse(idSenha);
      Navigator.of(context).pop();
    } catch (error) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: LIXEIRA_RESTAURAR_ERRO,
      );
    }
  }

  restaurarLixeira(BuildContext context, List<String> listaSenha) async {
    try {
      for (var item in listaSenha) await _senhaFirestore.toggleSenhaFalse(item);
      Navigator.of(context).pop();
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: LIXEIRA_RESTAURAR_ERRO,
      );
    }
  }

  void copiarSenha(BuildContext context, String texto) {
    Clipboard.setData(ClipboardData(text: texto));
    _toastClass.abrirToast(
      context: context,
      estilo: SenhaEnum.SUCESSO.value,
      texto: SENHA_COPIADA,
    );
  }
}
