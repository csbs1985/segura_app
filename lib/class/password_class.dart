import 'dart:math';
import 'package:segura_app/model/password_model.dart';

class PasswordClass {
  String gerarSenha(
    List<String> listSelected,
    int size,
  ) {
    const characters = '!@#\$%^&*()-_=+[]{}|;:,.<>/?';
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';

    final random = Random();
    String allowedCHaracters = '';

    if (listSelected.contains(PasswordEnum.CHARACTERS.name))
      allowedCHaracters += characters;
    if (listSelected.contains(PasswordEnum.UPPERCASE.name))
      allowedCHaracters += uppercase;
    if (listSelected.contains(PasswordEnum.LOWER_CASE.name))
      allowedCHaracters += lowerCase;
    if (listSelected.contains(PasswordEnum.NUMBERS.name))
      allowedCHaracters += numbers;

    String senha = '';
    for (int i = 0; i < size; i++) {
      int indice = random.nextInt(allowedCHaracters.length);
      senha += allowedCHaracters[indice];
    }

    return senha;
  }
}

enum PasswordTypeEnum {
  PAGE('page'),
  MODAL('modal');

  final String value;
  const PasswordTypeEnum(this.value);
}

enum PasswordEnum {
  CHARACTERS('caracteres especiais'),
  UPPERCASE('maiúscula'),
  LOWER_CASE('minúscula'),
  NUMBERS('números');

  final String value;
  const PasswordEnum(this.value);
}

final List<PasswordModel> listPassword = [
  PasswordModel(
    value: PasswordEnum.CHARACTERS.value,
    name: PasswordEnum.CHARACTERS.name,
  ),
  PasswordModel(
    value: PasswordEnum.UPPERCASE.value,
    name: PasswordEnum.UPPERCASE.name,
  ),
  PasswordModel(
    value: PasswordEnum.LOWER_CASE.value,
    name: PasswordEnum.LOWER_CASE.name,
  ),
  PasswordModel(
    value: PasswordEnum.NUMBERS.value,
    name: PasswordEnum.NUMBERS.name,
  ),
];
