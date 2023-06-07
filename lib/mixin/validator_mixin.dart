import 'package:senha_app/config/constante_config.dart';

mixin ValidatorMixin {
  String? inNotEmpty(String? value, [String? mensagem]) {
    if (value!.isEmpty) return mensagem ?? "este campo é obrigatório";
    return null;
  }

  String? isIdentificador(String nome, String link) {
    if (nome.isEmpty && link.isEmpty) return NOME_LINK;
    return null;
  }

  String? regexUrl(String? value) {
    RegExp urlRegex = RegExp(
      r'^(http(s)?:\/\/)?[\w.-]+(\.[\w.-]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$',
      caseSensitive: false,
      multiLine: false,
    );

    bool isURLValid = urlRegex.hasMatch(value!);

    if (value.isNotEmpty && !isURLValid) return LINK_INVALIDO;
    return null;
  }

  String? isSenhaCaracteres(String senha) {
    if (senha.length < 4 || senha.length > 32) return SENHA_CARACTERES;
    return null;
  }

  String? combinarValidacao(List<String? Function()> validators) {
    for (final item in validators) {
      final validacao = item();
      if (validacao != null) return validacao;
    }
    return null;
  }
}
