enum PasswordTypeEnum {
  PAGE('page'),
  MODAL('modal');

  final String value;
  const PasswordTypeEnum(this.value);
}

enum PasswordEnum {
  CARACTERES('caracteres especiais'),
  MAIUSCULA('maiúscula'),
  MINUSCULA('minúscula'),
  NUMEROS('números');

  final String value;
  const PasswordEnum(this.value);
}
