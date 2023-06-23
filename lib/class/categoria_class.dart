import 'package:flutter/material.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
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
      _categoriaFirestore.salvarCategoria(_categorias);
    } catch (e) {
      _toastClass.erro(
        context: context,
        texto: CATEGORIA_ERRO,
      );
    }
  }

  void deletarCategoria(
    BuildContext context,
    String _categoria,
  ) {
    try {
      _categoriaFirestore.deletarCategoria(_categoria);
    } catch (e) {
      _toastClass.erro(
        context: context,
        texto: CATEGORIA_EXLUIR_ERRO,
      );
    }
  }

  List<Map<String, dynamic>> verificarCategoria(String _categoria) {
    List<Map<String, dynamic>> lista = currentCategorias.value;
    lista.removeWhere((map) => map['idCategoria'] == _categoria);

    if (lista.any((map) => map['idCategoria'] == _categoria)) {
      for (var item in currentCategorias.value) {
        if (item['idCategoria'] == _categoria) {
          lista.add(item);
        }
      }
    }

    return lista;
  }
}
