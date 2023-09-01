import 'package:flutter/material.dart';
import 'package:segura_app/class/color_class.dart';
import 'package:segura_app/element/color_element.dart';
import 'package:segura_app/theme/ui_size.dart';

class ColorSelectWidget extends StatefulWidget {
  const ColorSelectWidget({
    super.key,
    required Function callback,
    required int color,
  })  : _callback = callback,
        _color = color;

  final Function _callback;
  final int _color;

  @override
  State<ColorSelectWidget> createState() => _ColorSelectWidgetState();
}

class _ColorSelectWidgetState extends State<ColorSelectWidget> {
  final ColorClass _colorClass = ColorClass();

  int _valueCurrent = 0;

  @override
  void initState() {
    super.initState();
    _selectColor(widget._color);
  }

  void _selectColor(int value) {
    setState(() => _valueCurrent = value);
    widget._callback(value);
  }

  bool _verifyColor(int item) {
    return _valueCurrent == item ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width - 32 - (5 * UiSize.spaceColor);
    final size = width / 6;

    return SingleChildScrollView(
      child: Wrap(
        spacing: UiSize.spaceColor,
        runSpacing: UiSize.spaceColor,
        alignment: WrapAlignment.start,
        children: List.generate(
          _colorClass.listColors.length,
          (index) {
            return ColorElement(
              callback: (value) => _selectColor(value),
              color: index,
              size: size,
              isSelected: true,
            );
          },
        ),
      ),
    );
  }
}
