import 'package:favicon/favicon.dart';
import 'package:intl/intl.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';

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
}
