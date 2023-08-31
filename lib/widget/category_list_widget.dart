import 'package:flutter/material.dart';
import 'package:segura_app/element/category_element.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({
    super.key,
    Function? callback,
    required List<Map<String, dynamic>> categories,
    bool? isColor = false,
    bool? isSmall = true,
  })  : _callback = callback,
        _categories = categories,
        _isColor = isColor,
        _isSmall = isSmall;

  final Function? _callback;
  final List<Map<String, dynamic>> _categories;
  final bool? _isColor;
  final bool? _isSmall;

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: widget._categories.map((item) {
        return CategoryElement(
          callback: (value) => {
            print(value),
          },
          element: item,
          isSelected: true,
        );
      }).toList(),
    );
  }
}
