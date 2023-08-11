import 'package:flutter/material.dart';
import 'package:segura_app/appbar/modal_appbar.dart';
import 'package:segura_app/class/color_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:unicons/unicons.dart';

class PaletteModal extends StatefulWidget {
  const PaletteModal({
    super.key,
    required Function callback,
    required int color,
  })  : _callback = callback,
        _color = color;

  final Function _callback;
  final int _color;

  @override
  State<PaletteModal> createState() => _PaletteModalState();
}

class _PaletteModalState extends State<PaletteModal> {
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModalAppBar(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    COLOR,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Wrap(
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
                                color: index == 0
                                    ? Theme.of(context).iconTheme.color!
                                    : color,
                                width: 0.3,
                              ),
                            ),
                            child: _verifyColor(index)
                                ? const Center(
                                    child: Icon(
                                      UniconsLine.check,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
