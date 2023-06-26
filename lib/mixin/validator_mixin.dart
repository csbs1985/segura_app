import 'package:senha_app/config/constante_config.dart';

mixin ValidatorMixin {
  String? inNotEmpty(String? value) {
    if (value!.isEmpty) return "este campo é obrigatório";
    return null;
  }

  String? regexUrl(String url) {
    RegExp regex = RegExp(
        r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)[a-zA-Z0-9]+([-.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,}(:[0-9]{1,5})?(\/.*)?$");

    bool isURLValid = regex.hasMatch(url);

    if (url.isNotEmpty && !isURLValid) return LINK_INVALIDO;
    return null;
  }

  String? isSenhaCaracteres(String senha) {
    if (senha.length < 4 || senha.length > 32)
      return SENHA_CARACTERES_DESCRICAO;
    return null;
  }

  String? isSenhaCaracteresInt(String senha) {
    int numero = int.parse(senha);
    if (numero < 4 || numero > 32) return SENHA_CARACTERES_DESCRICAO;
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
