class GerarSenhaModel {
  int index;
  String texto;
  bool selecionado;

  GerarSenhaModel({
    required this.index,
    required this.texto,
    required this.selecionado,
  });
}

final List<GerarSenhaModel> listaGeradorSenha = [
  GerarSenhaModel(index: 0, texto: 'letras maiúsculas', selecionado: false),
  GerarSenhaModel(index: 1, texto: 'letras minúsculas', selecionado: true),
  GerarSenhaModel(index: 2, texto: 'números', selecionado: false),
  GerarSenhaModel(index: 3, texto: 'caracteres especiais', selecionado: false),
];
