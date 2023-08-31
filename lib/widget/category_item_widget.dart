import 'package:flutter/material.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:text_transformation_animation/text_transformation_animation.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({
    super.key,
    Function? callback,
    required String category,
    bool? isColor = false,
    bool? isSmall = true,
  })  : _callback = callback,
        _category = category,
        _isColor = isColor,
        _isSmall = isSmall;

  final Function? _callback;
  final String _category;
  final bool? _isColor;
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
        return InkWell(
          borderRadius: BorderRadius.circular(UiBorder.rounded),
          child: Container(
            padding: widget._isSmall!
                ? const EdgeInsets.fromLTRB(12, 8, 12, 8)
                : const EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).iconTheme.color!.withOpacity(0.3),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              color: widget._isColor!
                  ? Theme.of(context).chipTheme.backgroundColor
                  : Colors.transparent,
            ),
            child: TextTransformationAnimation(
              text: _category.isEmpty ? "..." : _category['category'],
              duration: const Duration(milliseconds: 50),
              style: widget._isSmall!
                  ? Theme.of(context).textTheme.bodySmall
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          onTap: () => widget._callback != null ? widget._callback!() : null,
        );
      },
    );
  }
}
