import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class ListaButton extends StatefulWidget {
  const ListaButton({
    super.key,
    required Function callback,
    required String texto,
    required IconData icone,
  })  : _callback = callback,
        _icone = icone,
        _texto = texto;

  final Function _callback;
  final String _texto;
  final IconData _icone;

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
        child: Row(
          children: [
            ValueListenableBuilder(
                valueListenable: currentTema,
                builder: (BuildContext context, Brightness tema, _) {
                  bool isEscuro = tema == Brightness.dark;

                  return Icon(
                    widget._icone,
                    color: isEscuro ? UiCor.iconEscuro : UiCor.icon,
                  );
                }),
            const SizedBox(width: 16),
            TextoText(texto: widget._texto),
          ],
        ),
      ),
    );
  }
}
