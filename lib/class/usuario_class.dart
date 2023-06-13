import 'package:flutter/material.dart';
import 'package:senha_app/hive/usuario_hive.dart';
import 'package:senha_app/model/usuario_model.dart';

ValueNotifier<UsuarioModel> currentUsuario =
    ValueNotifier<UsuarioModel>(UsuarioModel(
  avatarUsuario: '',
  biometria: '',
  categorias: [],
  emailUsuario: '',
  idUsuario: '',
  nomeUsuario: '',
  senha: '',
));

class UsuarioClass {
  final UsuarioHive _usuarioHive = UsuarioHive();

  void postUsuarioHive(Map<dynamic, dynamic> usuario) async {
    await _usuarioHive.addUsuario({
      'avatarUsuario': usuario['avatarUsuario'],
      'biometria': usuario['biometria'],
      'categorias': usuario['categorias'],
      'emailUsuario': usuario['emailUsuario'],
      'idUsuario': usuario['idUsuario'],
      'nomeUsuario': usuario['nomeUsuario'],
      'senha': usuario['senha'],
    });
  }

  void postUsuarioCurrent(Map<dynamic, dynamic> usuario) {
    currentUsuario.value = UsuarioModel(
      avatarUsuario: usuario['avatarUsuario'],
      biometria: usuario['biometria'],
      categorias: usuario['categorias'].whereType<String>().toList(),
      emailUsuario: usuario['emailUsuario'],
      idUsuario: usuario['idUsuario'],
      nomeUsuario: usuario['nomeUsuario'],
      senha: usuario['senha'],
    );
  }
}
