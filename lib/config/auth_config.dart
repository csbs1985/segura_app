import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/firestore/usuario_firestore.dart';
import 'package:senha_app/hive/usuario_hive.dart';
import 'package:senha_app/model/usuario_model.dart';
import 'package:uuid/uuid.dart';

class AuthConfig extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();
  final UsuarioHive _usuarioHive = UsuarioHive();
  final Uuid uuid = const Uuid();

  User? usuario;

  bool isLoading = true;

  Map<String, dynamic>? usuarioMap;

  AuthConfig() {
    _definirUsuario();
  }

  _definirUsuario() {
    _auth.authStateChanges().listen((User? user) async {
      usuario = (user == null) ? null : user;
      _verificarHive();
      isLoading = false;
      notifyListeners();
    });
  }

  void verificarUsuarioFirestore() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> document =
          await _usuarioFirestore.getUsuarioDoc(user.uid);

      if (!document.exists) {
        usuarioMap = {
          'avatarUsuario': usuario!.photoURL,
          'biometria': "",
          'categorias': [],
          'emailUsuario': usuario!.email,
          'idUsuario': user.uid,
          'nomeUsuario': usuario!.displayName,
          'senha': "",
        };

        await _usuarioFirestore.postUsuario(usuarioMap!);
      } else {
        usuarioMap = {
          'avatarUsuario': document,
          'biometria': document,
          'categorias': [],
          'emailUsuario': document,
          'idUsuario': document,
          'nomeUsuario': document,
          'senha': document,
        };
      }

      _verificarHive();
    }
  }

  _verificarHive() async {
    if (_usuarioHive.verificarUsuario()) {
      final usuarioHive = await _usuarioHive.readUsuario();

      usuarioMap = {
        'avatarUsuario': usuarioHive['avatarUsuario'],
        'biometria': usuarioHive['biometria'],
        'categorias': usuarioHive['categorias'],
        'emailUsuario': usuarioHive['emailUsuario'],
        'idUsuario': usuarioHive['idUsuario'],
        'nomeUsuario': usuarioHive['nomeUsuario'],
        'senha': usuarioHive['senha'],
      };
    } else {
      usuarioMap = {
        'avatarUsuario': usuario!.photoURL,
        'biometria': "",
        'categorias': [],
        'emailUsuario': usuario!.email,
        'idUsuario': usuario!.uid,
        'nomeUsuario': usuario!.displayName,
        'senha': "",
      };

      await _usuarioHive.addUsuario(usuarioMap!);
    }

    currentUsuario.value = UsuarioModel(
      avatarUsuario: usuarioMap!['avatarUsuario'],
      biometria: usuarioMap!['biometria'],
      categorias: usuarioMap!['categorias'].whereType<String>().toList(),
      emailUsuario: usuarioMap!['emailUsuario'],
      idUsuario: usuarioMap!['idUsuario'],
      nomeUsuario: usuarioMap!['nomeUsuario'],
      senha: usuarioMap!['senha'],
    );
  }

  singInWithGoogle() async {
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    _definirUsuario();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOutWithGoogle() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _usuarioHive.deleteUsuario();
    _definirUsuario();
    notifyListeners();
  }
}
