import 'package:favicon/favicon.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';

class SenhaClass {
  final SenhaFirestore _senhaFirestore = SenhaFirestore();

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

  getSenhaId(String idSenha) async {
    await _senhaFirestore.getSenhaId(idSenha).then((result) => {
          result != null,
        });
  }

  postSenha(Map<String, dynamic> senha) async {
    await _senhaFirestore.postSenha(senha);
  }
}
