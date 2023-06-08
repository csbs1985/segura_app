import 'package:cloud_firestore/cloud_firestore.dart';

class SenhaFirestore {
  CollectionReference senhas = FirebaseFirestore.instance.collection('senhas');

  deletarSenhaId(String idSenha) async {
    return await senhas.doc(idSenha).delete();
  }

  getTodasSenhasUsuario(String idUsuario) {
    return senhas
        .orderBy('nome')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('deletado', isEqualTo: false);
  }

  getTodasSenhasUsuarioDetado(String idUsuario) {
    return senhas
        .orderBy('nome')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('deletado', isEqualTo: true);
  }

  getSenhaId(String idSenha) async {
    return await senhas.doc(idSenha).get();
  }

  patchDeletarSenhaId(String idSenha) {
    return senhas.doc(idSenha).update({'deletado': true});
  }

  postSenha(Map<String, dynamic> senha) async {
    return await senhas.doc(senha['idSenha']).set(senha);
  }
}
