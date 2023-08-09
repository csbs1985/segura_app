import 'package:flutter/material.dart';
import 'package:segura_app/class/toast_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/service/text_service.dart';

class CategoryClass {
  final CategoryFirestore _categoryFirestore = CategoryFirestore();
  final ToastClass _toastClass = ToastClass();

  List<Map<String, dynamic>> converterQuerySnapshotToList(snapshot) {
    List<Map<String, dynamic>> list = [];

    for (var document in snapshot) {
      Map<String, dynamic> data = document.data();
      data['id'] = document.id;
      list.add(data);
    }

    return list;
  }

  deleteCategory(BuildContext context, Map<String, dynamic> category) async {
    try {
      await _categoryFirestore.deleteCategory(category['categoryId']);
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: CATEGORY_DELETE_ERROR,
      );
    }
  }

  saveCategory(BuildContext context, Map<String, dynamic> category) async {
    try {
      await _categoryFirestore.saveCategory(category);
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: CATEGORY_SAVE_ERROR,
      );
    }
  }

  List<String> separateByComma(String inputString) {
    return inputString.contains(',') ? inputString.split(',') : [inputString];
  }
}
