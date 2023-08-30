import 'package:segura_app/service/text_service.dart';

mixin ValidatorMixin {
  String? isPasswordCharactersInt(String senha) {
    int numero = int.parse(senha);
    if (numero < 4 || numero > 32) return PASSWORD_CHARACTERS_ERROR;
    return null;
  }
}
