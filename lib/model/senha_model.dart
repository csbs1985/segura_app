class SenhaModel {
  late String? anotacao;
  late String dataRegistro;
  late String? expiracao;
  late String idSenha;
  late String idUsuario;
  late String? link;
  late String nome;
  late bool oculto; // indica se a senha deve aparecer ou não no formulario
  late String senha;
  late String usuario;

  SenhaModel(
    this.anotacao,
    this.dataRegistro,
    this.expiracao,
    this.idSenha,
    this.idUsuario,
    this.link,
    this.nome,
    this.oculto,
    this.senha,
    this.usuario,
  );
}
