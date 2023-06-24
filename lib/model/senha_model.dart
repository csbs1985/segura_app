class SenhaModel {
  late String? anotacao;
  late List<String> categoria;
  late List<String> compartilhada;
  late String dataRegistro;
  late String idSenha;
  late String idUsuario;
  late String? link;
  late bool lixeira;
  late String nome;
  late String senha;
  late String usuario;

  SenhaModel({
    this.anotacao,
    required this.categoria,
    required this.compartilhada,
    required this.dataRegistro,
    required this.idSenha,
    required this.idUsuario,
    this.link,
    required this.lixeira,
    required this.nome,
    required this.senha,
    required this.usuario,
  });
}
