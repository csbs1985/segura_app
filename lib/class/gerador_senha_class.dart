class GerarSenhaModel {
  String value;
  String texto;

  GerarSenhaModel({
    required this.value,
    required this.texto,
  });
}

final List<GerarSenhaModel> listaGeradorSenha = [
  GerarSenhaModel(value: 'caracteres', texto: GerarSenhaEnum.CARACTERES.value),
  GerarSenhaModel(value: 'maiuscula', texto: GerarSenhaEnum.MAIUSCULA.value),
  GerarSenhaModel(value: 'minuscula', texto: GerarSenhaEnum.MINUSCULA.value),
  GerarSenhaModel(value: 'numeros', texto: GerarSenhaEnum.NUMEROS.value),
];

enum GerarSenhaEnum {
  CARACTERES('caracteres'),
  MAIUSCULA('maiuscula'),
  MINUSCULA('minuscula'),
  NUMEROS('numeros');

  final String value;
  const GerarSenhaEnum(this.value);
}
