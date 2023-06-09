import 'package:cloud_firestore/cloud_firestore.dart';

class SenhaFirestore {
  CollectionReference senhas = FirebaseFirestore.instance.collection('senhas');

  deleteSenhaId(String idSenha) async {
    return await senhas.doc(idSenha).delete();
  }

  getTodasSenhas(String idUsuario) {
    return senhas
        .orderBy('nome')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('lixeira', isEqualTo: false);
  }

  getTodasSenhasUsuarioGet(String idUsuario) {
    return senhas
        .orderBy('nome')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('lixeira', isEqualTo: true)
        .get();
  }

  getTodasSenhasLixeira(String idUsuario) {
    return senhas
        .orderBy('nome')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('lixeira', isEqualTo: true);
  }

  getSenhaId(String idSenha) async {
    return await senhas.doc(idSenha).get();
  }

  toggleSenhaTrue(String idSenha) {
    return senhas.doc(idSenha).update({'lixeira': true});
  }

  toggleSenhaFalse(String idSenha) {
    return senhas.doc(idSenha).update({'lixeira': false});
  }

  postSenha(Map<String, dynamic> senha) async {
    return await senhas.doc(senha['idSenha']).set(senha);
  }
}
