class SenhaModel {
  late String dataRegistro;
  late bool expiracao;
  late String senha;
  late bool oculto; // indica se a senha deve aparecer ou não no formulario
  late String texto;
  late String titulo;

  SenhaModel(
    this.expiracao,
    this.dataRegistro,
    this.oculto,
    this.senha,
    this.texto,
    this.titulo,
  );
}
