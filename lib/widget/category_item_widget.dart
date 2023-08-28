import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({
    super.key,
    Function? callback,
    required Map<String, dynamic> category,
    bool? isColor = false,
    bool? isSmall = true,
  })  : _callback = callback,
        _category = category,
        _isColor = isColor,
        _isSmall = isSmall;

  final Function? _callback;
  final Map<String, dynamic> _category;
  final bool? _isColor;
  final bool? _isSmall;

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  @override
  Widget build(BuildContext context) {
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
              : null,
        ),
        child: Text(
          widget._category['category'],
          style: widget._isSmall!
              ? Theme.of(context).textTheme.bodySmall
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      onTap: () => widget._callback!(),
    );
  }
}
