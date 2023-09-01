import 'package:flutter/material.dart';
import 'package:segura_app/class/color_class.dart';

class ColorElement extends StatefulWidget {
  const ColorElement({
    super.key,
    required Function callback,
    required int color,
    bool? isSelected = false,
    required double size,
  })  : _callback = callback,
        _color = color,
        _isSelected = isSelected,
        _size = size;

  final Function _callback;
  final int _color;
  final bool? _isSelected;
  final double _size;

  @override
  State<ColorElement> createState() => _ColorElementState();
}

class _ColorElementState extends State<ColorElement> {
  final ColorClass _colorClass = ColorClass();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget._size,
        height: widget._size,
        decoration: BoxDecoration(
          color: _colorClass.getColor(widget._color),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget._color == 0
                ? Theme.of(context).iconTheme.color!.withOpacity(0.3)
                : _colorClass.getColor(widget._color),
            width: 0.3,
          ),
        ),
        child: widget._isSelected!
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      onTap: () => widget._callback(widget._color),
    );
  }
}
