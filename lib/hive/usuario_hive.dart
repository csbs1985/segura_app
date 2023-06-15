import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UsuarioHive {
  final _usuarioBox = Hive.box('usuario');

  salvarUsuario(Map<String, dynamic> usuario) async {
    await _usuarioBox.add(usuario);
  }

  deletarUsuario() async {
    await _usuarioBox.clear();
  }

  receberUsuario() {
    return _usuarioBox.values.first;
  }

  verificarUsuario() {
    return _usuarioBox.isNotEmpty;
  }
}
