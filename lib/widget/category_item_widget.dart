import 'package:flutter/material.dart';
import 'package:segura_app/element/category_element.dart';
import 'package:segura_app/firestore/category_firestore.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({
    super.key,
    Function? callback,
    required String category,
    int? color,
    bool? isSmall = true,
  })  : _callback = callback,
        _category = category,
        _color = color,
        _isSmall = isSmall;

  final Function? _callback;
  final String _category;
  final int? _color;
  final bool? _isSmall;

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  final CategoryFirestore _categoryFirestore = CategoryFirestore();

  Map<String, dynamic> _category = {};

  @override
  void initState() {
    super.initState();
    _fetchCategory();
  }

  Future<void> _fetchCategory() async {
    _category = {};

    final result = await _categoryFirestore.getCategoryId(widget._category);
    Map<String, dynamic> item =
        result.docs.first.data() as Map<String, dynamic>;
    _category = item;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchCategory(),
      builder: (BuildContext context, _) {
        return CategoryElement(
          callback: (value) => {
            print(value),
          },
          color: widget._color ?? 0,
          element: _category,
          isSmall: widget._isSmall,
        );
      },
    );
  }
}
