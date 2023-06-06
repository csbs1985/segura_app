import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthConfig extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? usuario;

  bool isLoading = true;

  AuthConfig() {
    _definirUsuario();
  }

  _definirUsuario() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
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
    _definirUsuario();
    notifyListeners();
  }
}
