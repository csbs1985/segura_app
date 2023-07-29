import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/model/user_model.dart';
import 'package:segura_app/service/value_notifier_service.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserHive _userHive = UserHive();

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user != null ? _saveUser(user) : null;
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        return null;
      }
      if (e.code == 'sign_in_failed') {
        print('O usuário cancelou a operação de login com o Google.');
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = authResult.user;

      return user != null ? _saveUser(user) : null;
    } catch (e) {
      return null;
    }
  }

  UserModel _saveUser(User user) {
    currentUser.value = UserModel(
      userAvatar: user.photoURL!,
      userId: user.uid,
      userName: user.displayName!,
      userEmail: user.email!,
    );

    return UserModel(
      userId: user.uid,
      userName: user.displayName!,
      userEmail: user.email!,
      userAvatar: user.photoURL!,
    );
  }

  Future<void> signOut() async {
    await _userHive.deleteUser();
    await _googleSignIn.signOut();
  }
}
