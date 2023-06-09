import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_texto.dart';

class ErroText extends StatelessWidget {
  const ErroText({
    super.key,
    required String texto,
  }) : _texto = texto;

  final String _texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Text(
        _texto,
        style: UiTexto.erro,
      ),
    );
  }
}
