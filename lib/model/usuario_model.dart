// ignore_for_file: public_member_api_docs, sort_constructors_first

class UsuarioModel {
  late String avatarUsuario;
  late bool biometria;
  late List<String> categorias;
  late String emailUsuario;
  late String idUsuario;
  late String nomeUsuario;

  UsuarioModel({
    required this.avatarUsuario,
    required this.biometria,
    required this.categorias,
    required this.emailUsuario,
    required this.idUsuario,
    required this.nomeUsuario,
  });

  static Map<String, dynamic> toMap(usuario) {
    return <String, dynamic>{
      'avatarUsuario': usuario['avatarUsuario'],
      'biometria': usuario['biometria'],
      'categorias': usuario['categorias'],
      'emailUsuario': usuario['emailUsuario'],
      'idUsuario': usuario['idUsuario'],
      'nomeUsuario': usuario['nomeUsuario'],
    };
  }
}
