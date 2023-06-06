import 'package:cloud_firestore/cloud_firestore.dart';

class SenhaFirestore {
  CollectionReference senhas = FirebaseFirestore.instance.collection('senhas');

  getTodasSenhasUsuario(String idUsuario) {
    return senhas.orderBy('nome').where('idUsuario', isEqualTo: idUsuario);
  }

  snapshotsSenhaId(String idUsuario) {
    return senhas.where('idUsuario', isEqualTo: idUsuario).snapshots();
  }

  postSenhaId(Map<String, dynamic> senha) async {
    return await senhas.doc(senha['idSenha']).set(senha);
  }
}
