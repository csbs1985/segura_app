import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriaFirestore {
  CollectionReference categorias =
      FirebaseFirestore.instance.collection('categorias');

  editarToogleBiometria(String usuario, bool biometria) {
    return categorias.doc(usuario).update({'biometria': biometria});
  }

  receberTodasCategoriasUsuario(String idUsuario) {
    return categorias
        .where('idUsuario', isEqualTo: idUsuario)
        .orderBy("textoCategoria")
        .snapshots();
  }

  editarCategoriaUsuario(Map<String, dynamic> _categorias) {
    return categorias
        .doc(_categorias['idCategoria'])
        .update({'categorias': _categorias});
  }

  salvarCategoriaUsuario(Map<String, dynamic> _categorias) async {
    return await categorias.doc(_categorias['idSenha']).set(_categorias);
  }
}
