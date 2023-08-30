import 'package:flutter/material.dart';
import 'package:segura_app/appbar/modal_appbar.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/widget/select_color_widget.dart';

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
            SelectColorWidget(
              callback: (value) => widget._callback(value),
              color: widget._color,
            ),
          ],
        ),
      ),
    );
  }
}
