import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:segura_app/model/category_model.dart';

class CategoryFirestore {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  deleteCategory(String categoryId) {
    return categories.doc(categoryId).delete();
  }

  editCategory(CategoryModel category) {
    return categories.doc(category.categoryId).update({'categories': category});
  }

  saveCategory(CategoryModel category) async {
    return await categories.doc(category.categoryId).set(category);
  }

  snapshotsCategory(String userId) {
    return categories
        .where('userId', isEqualTo: userId)
        .orderBy("category")
        .snapshots();
  }

  getAllCategories(String userId) {
    return categories.orderBy('category').where('userId', isEqualTo: userId);
  }
}
