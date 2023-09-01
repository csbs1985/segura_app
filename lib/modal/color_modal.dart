import 'package:flutter/material.dart';
import 'package:segura_app/appbar/modal_appbar.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/widget/color_select_widget.dart';

class ColorModal extends StatefulWidget {
  const ColorModal({
    super.key,
    required Function callback,
    required int color,
  })  : _callback = callback,
        _color = color;

  final Function _callback;
  final int _color;

  @override
  State<ColorModal> createState() => _ColorModalState();
}

class _ColorModalState extends State<ColorModal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModalAppBar(text: COLOR),
            const SizedBox(height: 16),
            ColorSelectWidget(
              callback: (value) => widget._callback(value),
              color: widget._color,
            ),
          ],
        ),
      ),
    );
  }
}
