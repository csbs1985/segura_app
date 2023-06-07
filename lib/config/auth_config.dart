import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/hive/usuario_hive.dart';
import 'package:senha_app/model/usuario_model.dart';

class AuthConfig extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UsuarioHive _usuarioHive = UsuarioHive();

  User? usuario;

  bool isLoading = true;

  AuthConfig() {
    _definirUsuario();
  }

  _definirUsuario() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      if (user != null) _verificarHive();
      isLoading = false;
      notifyListeners();
    });
  }

  _verificarHive() async {
    Map<String, dynamic> usuarioMap = {
      'avatarUsuario': usuario!.photoURL,
      'emailUsuario': usuario!.email,
      'idUsuario': usuario!.uid,
      'nomeUsuario': usuario!.displayName,
    };

    await _usuarioHive.addUsuario(usuarioMap);

    currentUsuario.value = UsuarioModel(
      avatarUsuario: usuarioMap['avatarUsuario'],
      emailUsuario: usuarioMap['emailUsuario'],
      idUsuario: usuarioMap['idUsuario'],
      nomeUsuario: usuarioMap['nomeUsuario'],
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
