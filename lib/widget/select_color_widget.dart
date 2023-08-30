import 'package:flutter/material.dart';
import 'package:segura_app/class/color_class.dart';
import 'package:segura_app/theme/ui_size.dart';

class SelectColorWidget extends StatefulWidget {
  const SelectColorWidget({
    super.key,
    required Function callback,
    required int color,
  })  : _callback = callback,
        _color = color;

  final Function _callback;
  final int _color;

  @override
  State<SelectColorWidget> createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  final ColorClass _colorClass = ColorClass();

  int _valueCurrent = 0;

  @override
  void initState() {
    super.initState();
    _selectColor(widget._color, false);
  }

  void _selectColor(int item, bool isChange) {
    setState(() => _valueCurrent = item);
    widget._callback(item);
  }

  bool _verifyColor(int item) {
    return _valueCurrent == item ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width - 32 - (5 * UiSize.spaceColor);
    final sizeWidth = width / 6;

    return SingleChildScrollView(
      child: Wrap(
        spacing: UiSize.spaceColor,
        runSpacing: UiSize.spaceColor,
        alignment: WrapAlignment.start,
        children: List.generate(
          _colorClass.listColors.length,
          (index) {
            int value = _colorClass.listColors[index]["value"];
            Color color = _colorClass.getColor(value);

            return GestureDetector(
              onTap: () => _selectColor(index, true),
              child: Container(
                width: sizeWidth,
                height: sizeWidth,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        index == 0 ? Theme.of(context).iconTheme.color! : color,
                    width: 0.3,
                  ),
                ),
                child: _verifyColor(index)
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
