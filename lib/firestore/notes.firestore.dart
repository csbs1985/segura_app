import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestore {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  getAllNotes(String idUsuario) {
    return notes
        .orderBy('note')
        .where('idUser', isEqualTo: idUsuario)
        .where('excluded', isEqualTo: false);
  }
}
