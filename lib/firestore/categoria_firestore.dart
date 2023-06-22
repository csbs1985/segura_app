import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriaFirestore {
  CollectionReference categorias =
      FirebaseFirestore.instance.collection('categorias');

  deletarCategoria(String _idCategoria) {
    return categorias.doc(_idCategoria).delete();
  }

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

  salvarCategoria(Map<String, dynamic> _categorias) async {
    return await categorias.doc(_categorias['idCategoria']).set(_categorias);
  }
}
