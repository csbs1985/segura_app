import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestore {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> saveUser(Map<String, dynamic> user) async {
    return await users.doc(user['id']).set(user);
  }
}
