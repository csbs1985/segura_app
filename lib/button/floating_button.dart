import 'package:flutter/material.dart';
import 'package:senha_app/button/segundo_button.dart';

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
    return SegundoButton(
      icone: widget._icone,
      callback: () => widget._callback(),
    );
  }
}
