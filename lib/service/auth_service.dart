import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/model/user_model.dart';

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

      return user != null
          ? UserModel(
              id: user.uid,
              name: user.displayName!,
              email: user.email!,
              avatar: '')
          : null;
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

      return user != null
          ? UserModel(
              id: user.uid,
              name: user.displayName!,
              email: user.email!,
              avatar: '')
          : null;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _userHive.deleteUser();
    await _googleSignIn.signOut();
  }
}
