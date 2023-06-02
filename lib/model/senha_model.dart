class SenhaModel {
  late String dataRegistro;
  late bool expiracao;
  late String senha;
  late String texto;
  late String titulo;

  SenhaModel(
    this.expiracao,
    this.dataRegistro,
    this.senha,
    this.texto,
    this.titulo,
  );
}
