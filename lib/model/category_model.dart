class CategoryModel {
  late String categoryId;
  late String userId;
  late String category;

  CategoryModel({
    required this.categoryId,
    required this.userId,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'userId': userId,
      'category': category,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'],
      userId: map['userId'],
      category: map['category'],
    );
  }
}
