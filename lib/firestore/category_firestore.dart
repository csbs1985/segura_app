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

  saveCategory(Map<String, dynamic> category) async {
    return await categories.doc(category['categoryId']).set(category);
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

  getCategoryId(String categoryId) async {
    return await categories.where('categoryId', isEqualTo: categoryId).get();
  }
}
