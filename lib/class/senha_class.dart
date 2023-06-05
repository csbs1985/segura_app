import 'package:favicon/favicon.dart';

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
    return " · alterada há $diferenca dias";
  }
}
