import 'package:favicon/favicon.dart';
import 'package:senha_app/config/constante_config.dart';

class SenhaClass {
  Future<String> definirFavicon(String url) async {
    final favicon = await FaviconFinder.getBest(url);
    return favicon!.url;
  }

  String ultimaAlteracaoSenha(String data) {
    final DateTime registro = DateTime.parse(data);
    final DateTime hoje = DateTime.now();
    final difference = registro.difference(hoje);
    final diferenca = difference.inDays.abs();
    return "$SENHA_ALTERACAO_1 $diferenca $SENHA_ALTERACAO_2";
  }
}
