import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senha_app/hive/usuario_hive.dart';
import 'package:senha_app/model/usuario_model.dart';

ValueNotifier<UsuarioModel> currentUsuario = ValueNotifier<UsuarioModel>(
  UsuarioModel(
    avatarUsuario: '',
    biometria: '',
    categorias: [],
    emailUsuario: '',
    idUsuario: '',
    nomeUsuario: '',
    senha: '',
  ),
);

class UsuarioClass {
  final UsuarioHive _usuarioHive = UsuarioHive();

  Map<String, dynamic> conveterDymanicToString(Map<dynamic, dynamic> usuario) {
    Map<String, dynamic> usuarioMap = {};

    usuario.forEach((chave, valor) {
      usuarioMap[chave.toString()] = valor;
    });

    return usuarioMap;
  }

  Map<String, dynamic> postUsuarioSnapshot(
    QuerySnapshot<Map<String, dynamic>> usuario,
  ) {
    DocumentSnapshot<Map<String, dynamic>> doc = usuario.docs.first;

    Map<String, dynamic> usuarioMap = {
      'avatarUsuario': doc['avatarUsuario'],
      'biometria': doc['biometria'],
      'categorias': doc['categorias'],
      'emailUsuario': doc['emailUsuario'],
      'idUsuario': doc['idUsuario'],
      'nomeUsuario': doc['nomeUsuario'],
      'senha': doc['senha'],
    };

    return usuarioMap;
  }

  Map<String, dynamic> postUsuarioUser(User usuario) {
    Map<String, dynamic> usuarioMap = {
      'avatarUsuario': usuario.photoURL,
      'biometria': "",
      'categorias': [],
      'emailUsuario': usuario.email,
      'idUsuario': usuario.uid,
      'nomeUsuario': usuario.displayName,
      'senha': "",
    };

    return usuarioMap;
  }

  void postUsuarioHive(Map<String, dynamic> usuario) async {
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

  void postUsuarioCurrent(Map<String, dynamic> usuario) {
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
