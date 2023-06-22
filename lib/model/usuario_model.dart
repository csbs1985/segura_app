class UsuarioModel {
  late String avatarUsuario;
  late bool biometria;
  late String emailUsuario;
  late String idUsuario;
  late String nomeUsuario;

  UsuarioModel({
    required this.avatarUsuario,
    required this.biometria,
    required this.emailUsuario,
    required this.idUsuario,
    required this.nomeUsuario,
  });

  static Map<String, dynamic> toMap(usuario) {
    return <String, dynamic>{
      'avatarUsuario': usuario['avatarUsuario'],
      'biometria': usuario['biometria'],
      'emailUsuario': usuario['emailUsuario'],
      'idUsuario': usuario['idUsuario'],
      'nomeUsuario': usuario['nomeUsuario'],
    };
  }
}
