import 'package:cloud_firestore/cloud_firestore.dart';

class SenhaFirestore {
  CollectionReference senhas = FirebaseFirestore.instance.collection('senhas');

  deletarSenhaId(String idSenha) async {
    return await senhas.doc(idSenha).delete();
  }

  receberTodasSenhas(String idUsuario) {
    return senhas
        .orderBy('nome')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('lixeira', isEqualTo: false);
  }

  receberTodasSenhasLixeira(String idUsuario) {
    return senhas
        .orderBy('nome')
        .where('idUsuario', isEqualTo: idUsuario)
        .where('lixeira', isEqualTo: true);
  }

  receberSenhaId(String idSenha) async {
    return await senhas.doc(idSenha).get();
  }

  editarSenhaDeletadaTrue(String idSenha) {
    return senhas.doc(idSenha).update({'lixeira': true});
  }

  editarSenhaDeletadaFalse(String idSenha) {
    return senhas.doc(idSenha).update({'lixeira': false});
  }

  salvarSenha(Map<String, dynamic> senha) async {
    return await senhas.doc(senha['idSenha']).set(senha);
  }
}
