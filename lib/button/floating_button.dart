import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({
    super.key,
    required Function callback,
    required IconData icone,
  })  : _callback = callback,
        _icone = icone;

  final Function _callback;
  final IconData _icone;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => widget._callback(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.arredondada)),
      child: Icon(
        widget._icone,
        size: UiTamanho.iconefloating,
        color: UiCor.floating,
      ),
    );
  }
}
