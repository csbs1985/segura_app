import 'package:cloud_firestore/cloud_firestore.dart';

class SenhaFirestore {
  CollectionReference senhas = FirebaseFirestore.instance.collection('senhas');

  getTodasSenhasUsuario(String idUsuario) {
    return senhas.orderBy('nome').where('idUsuario', isEqualTo: idUsuario);
  }

  getSenhaId(String idSenha) async {
    return await senhas.where('idSenha', isEqualTo: idSenha).get();
  }

  postSenhaId(Map<String, dynamic> senha) async {
    return await senhas.doc(senha['idSenha']).set(senha);
  }
}
