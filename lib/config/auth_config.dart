import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/firestore/usuario_firestore.dart';
import 'package:senha_app/hive/usuario_hive.dart';
import 'package:uuid/uuid.dart';

class AuthConfig extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UsuarioClass _usuarioClass = UsuarioClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();
  final UsuarioHive _usuarioHive = UsuarioHive();
  final Uuid uuid = const Uuid();

  User? usuario;

  Map<String, dynamic>? usuarioMap;

  AuthConfig() {
    _definirUsuario();
  }

  _definirUsuario() {
    _auth.authStateChanges().listen((User? user) async {
      usuario = (user == null) ? null : user;
      _verificarUsuarioFirestore();
      notifyListeners();
    });
  }

  void _verificarUsuarioFirestore() async {
    if (usuario != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _usuarioFirestore.receberUsuarioId(usuario!.uid);

      if (querySnapshot.docs.isNotEmpty) {
        usuarioMap = _usuarioClass.salvarUsuarioSnapshot(querySnapshot);
      } else {
        usuarioMap = _usuarioClass.salvarUsuarioUser(usuario!);
        await _usuarioFirestore.salvarUsuario(usuarioMap!);
      }
      _verificarUsuarioHive();
    }
  }

  _verificarUsuarioHive() async {
    if (_usuarioHive.verificarUsuario()) {
      Map<dynamic, dynamic> usuarioDynamic =
          await _usuarioHive.receberUsuario();
      usuarioMap = _usuarioClass.conveterDymanicToString(usuarioDynamic);
    } else {
      final usuarioMap = _usuarioClass.salvarUsuarioUser(usuario!);
      _usuarioClass.salvarUsuarioHive(usuarioMap);
    }

    _usuarioClass.salvarUsuarioCurrent(usuarioMap!);
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
    _usuarioHive.deletarUsuario();
    _definirUsuario();
    notifyListeners();
  }
}
