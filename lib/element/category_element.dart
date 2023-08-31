import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:text_transformation_animation/text_transformation_animation.dart';

class CategoryElement extends StatefulWidget {
  const CategoryElement({
    super.key,
    required Function callback,
    required Map<String, dynamic> element,
    bool? isSelected = false,
    bool? isSmall = false,
  })  : _callback = callback,
        _element = element,
        _isSelected = isSelected,
        _isSmall = isSmall;

  final Function _callback;
  final Map<String, dynamic> _element;
  final bool? _isSelected;
  final bool? _isSmall;

  @override
  State<CategoryElement> createState() => _CategoryElementState();
}

class _CategoryElementState extends State<CategoryElement> {
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = widget._isSmall!
        ? Theme.of(context).textTheme.bodySmall
        : Theme.of(context).textTheme.bodyMedium;

    TextStyle coloredTextStyle = textStyle!.copyWith(
      color: widget._isSelected! ? Colors.white : textStyle.color,
    );

    return GestureDetector(
      child: Container(
        padding: widget._isSmall!
            ? const EdgeInsets.fromLTRB(14, 8, 14, 8)
            : const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget._isSelected!
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).iconTheme.color!.withOpacity(0.3),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(UiBorder.rounded),
          color: widget._isSelected!
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
        ),
        child: TextTransformationAnimation(
          text: widget._element.isEmpty ? "..." : widget._element['category'],
          duration: const Duration(milliseconds: 10),
          style: coloredTextStyle,
        ),
      ),
      onTap: () => widget._callback(widget._element),
    );
  }
}
