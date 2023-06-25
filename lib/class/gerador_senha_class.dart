import 'package:senha_app/modal/gerar_senha_model.dart';

final List<GerarSenhaModel> listaGeradorSenha = [
  GerarSenhaModel(
      value: GerarSenhaEnum.CARACTERES.name,
      texto: GerarSenhaEnum.CARACTERES.value),
  GerarSenhaModel(
      value: GerarSenhaEnum.MAIUSCULA.name,
      texto: GerarSenhaEnum.MAIUSCULA.value),
  GerarSenhaModel(
      value: GerarSenhaEnum.MINUSCULA.name,
      texto: GerarSenhaEnum.MINUSCULA.value),
  GerarSenhaModel(
      value: GerarSenhaEnum.NUMEROS.name, texto: GerarSenhaEnum.NUMEROS.value),
];

enum GerarSenhaEnum {
  CARACTERES('caracteres especiais'),
  MAIUSCULA('maiúscula'),
  MINUSCULA('minúscula'),
  NUMEROS('números');

  final String value;
  const GerarSenhaEnum(this.value);
}

enum GerarSenhaTipoEnum {
  PAGE('page'),
  MODAL('modal');

  final String value;
  const GerarSenhaTipoEnum(this.value);
}
