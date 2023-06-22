import 'package:flutter/material.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/categoria_firestore.dart';

class CategoriaClass {
  final CategoriaFirestore _categoriaFirestore = CategoriaFirestore();
  final ToastClass _toastClass = ToastClass();

  List<Map<String, dynamic>> converterQuerySnapshotToList(snapshot) {
    List<Map<String, dynamic>> listaCategorias = [];

    for (var document in snapshot) {
      Map<String, dynamic> data = document.data();
      data['id'] = document.id;
      listaCategorias.add(data);
    }

    return listaCategorias;
  }

  void salvarCategoria(BuildContext context, Map<String, dynamic> _categorias) {
    try {
      _categoriaFirestore.salvarCategoriaUsuario(_categorias);
    } catch (e) {
      _toastClass.erro(
        context: context,
        texto: CATEGORIA_ERRO,
      );
    }
  }
}
