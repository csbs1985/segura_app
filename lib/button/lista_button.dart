import 'package:flutter/material.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class ListaButton extends StatefulWidget {
  const ListaButton({
    super.key,
    required Function callback,
    required String texto,
  })  : _callback = callback,
        _texto = texto;

  final Function _callback;
  final String _texto;

  @override
  State<ListaButton> createState() => _ListaButtonState();
}

class _ListaButtonState extends State<ListaButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget._callback(),
      child: Container(
        width: double.infinity,
        height: UiTamanho.appbar,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        child: TextoText(texto: widget._texto),
      ),
    );
  }
}
