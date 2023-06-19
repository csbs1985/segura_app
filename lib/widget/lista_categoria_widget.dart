import 'package:flutter/material.dart';
import 'package:senha_app/class/texto_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class ItemCategoriaWidget extends StatelessWidget {
  final TextoClass _textoClass = TextoClass();

  ItemCategoriaWidget({
    super.key,
    required List<dynamic> categoria,
  }) : _categoria = categoria;

  List<dynamic> _categoria;

  @override
  Widget build(BuildContext context) {
    _categoria = _textoClass.ordenarCrescente(_categoria);

    return Wrap(
      children: [
        for (var item in _categoria)
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
            child: GestureDetector(
              // onTap: () => _onTap(),
              child: ValueListenableBuilder(
                valueListenable: currentTema,
                builder: (BuildContext context, Brightness tema, _) {
                  bool isEscuro = tema == Brightness.dark;

                  return Container(
                    height: UiTamanho.categoria,
                    decoration: BoxDecoration(
                      color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                      borderRadius: BorderRadius.circular(UiBorda.arredondada),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                    child: TextoText(texto: item),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
