import 'package:flutter/material.dart';
import 'package:segura_app/element/category_element.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({
    super.key,
    required Function callback,
    required List<Map<String, dynamic>> categories,
    int? color = 0,
    bool? isSelected = false,
    bool? isSmall = false,
  })  : _callback = callback,
        _categories = categories,
        _color = color,
        _isSelected = isSelected,
        _isSmall = isSmall;

  final Function? _callback;
  final List<Map<String, dynamic>> _categories;
  final int? _color;
  final bool? _isSelected;
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
          callback: (value) => widget._callback!(value),
          color: widget._color,
          element: item,
          isSelected: widget._isSelected,
          isSmall: widget._isSmall,
        );
      }).toList(),
    );
  }
}
