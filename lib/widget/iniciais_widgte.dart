import 'package:flutter/material.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_texto.dart';

class IniciaisWidget extends StatefulWidget {
  const IniciaisWidget({
    super.key,
    required String texto,
  }) : _texto = texto;

  final String _texto;

  @override
  State<IniciaisWidget> createState() => _IniciaisWidgetState();
}

class _IniciaisWidgetState extends State<IniciaisWidget> {
  final SenhaClass _senhaClass = SenhaClass();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: UiCor.segunda,
      ),
      child: Center(
        child: Text(
          _senhaClass.definirPrimeirasLetras(widget._texto),
          style: UiTexto.tagAtiva,
        ),
      ),
    );
  }
}
