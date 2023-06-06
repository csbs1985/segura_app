import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class IconeButton extends StatefulWidget {
  const IconeButton({
    super.key,
    required Function callback,
    required IconData icone,
  })  : _callback = callback,
        _icone = icone;

  final Function _callback;
  final IconData _icone;

  @override
  State<IconeButton> createState() => _IconeButtonState();
}

class _IconeButtonState extends State<IconeButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UiTamanho.icone,
      height: UiTamanho.icone,
      child: InkWell(
        borderRadius: BorderRadius.circular(UiBorda.circulo),
        child: Icon(widget._icone),
        onTap: () => widget._callback(),
      ),
    );
  }
}
