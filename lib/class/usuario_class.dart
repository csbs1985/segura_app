import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/firestore/usuario_firestore.dart';
import 'package:senha_app/hive/usuario_hive.dart';
import 'package:senha_app/model/usuario_model.dart';

class UsuarioClass {
  final ToastClass _toastClass = ToastClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();
  final UsuarioHive _usuarioHive = UsuarioHive();

  Map<String, dynamic> conveterDymanicToString(Map<dynamic, dynamic> usuario) {
    Map<String, dynamic> usuarioMap = {};

    usuario.forEach((chave, valor) {
      usuarioMap[chave.toString()] = valor;
    });

    return usuarioMap;
  }

  Map<String, dynamic> salvarUsuarioSnapshot(
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
    };

    return usuarioMap;
  }

  Map<String, dynamic> salvarUsuarioUser(User usuario) {
    Map<String, dynamic> usuarioMap = {
      'avatarUsuario': usuario.photoURL,
      'biometria': false,
      'categorias': [],
      'emailUsuario': usuario.email,
      'idUsuario': usuario.uid,
      'nomeUsuario': usuario.displayName,
    };

    return usuarioMap;
  }

  void salvarUsuarioHive(Map<String, dynamic> usuario) async {
    await _usuarioHive.deletarUsuario();

    await _usuarioHive.salvarUsuario({
      'avatarUsuario': usuario['avatarUsuario'],
      'biometria': usuario['biometria'],
      'categorias': usuario['categorias'],
      'emailUsuario': usuario['emailUsuario'],
      'idUsuario': usuario['idUsuario'],
      'nomeUsuario': usuario['nomeUsuario'],
    });
  }

  void salvarUsuarioCurrent(Map<String, dynamic> usuario) {
    currentUsuario.value = UsuarioModel(
      avatarUsuario: usuario['avatarUsuario'],
      biometria: usuario['biometria'],
      categorias: usuario['categorias'].whereType<String>().toList(),
      emailUsuario: usuario['emailUsuario'],
      idUsuario: usuario['idUsuario'],
      nomeUsuario: usuario['nomeUsuario'],
    );
  }

  void toogleBiometria(BuildContext context, bool biometria) {
    try {
      editarUsuarioHiveBiometria(biometria);

      _usuarioFirestore.editarToogleBiometria(
        currentUsuario.value.idUsuario,
        biometria,
      );
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: MODO_ENTRADA_ERRO,
      );
    }
  }

  editarUsuarioHiveBiometria(bool biometria) async {
    Map<dynamic, dynamic> usuario = await _usuarioHive.receberUsuario();

    Map<String, dynamic> usuarioMap = {
      'avatarUsuario': usuario['avatarUsuario'],
      'biometria': biometria,
      'categorias': usuario['categorias'],
      'emailUsuario': usuario['emailUsuario'],
      'idUsuario': usuario['idUsuario'],
      'nomeUsuario': usuario['nomeUsuario'],
    };

    salvarUsuarioHive(usuarioMap);
    salvarUsuarioCurrent(usuarioMap);
  }
}
