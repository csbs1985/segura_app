import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class ListaCategoriaSenhaWidget extends StatefulWidget {
  const ListaCategoriaSenhaWidget({
    super.key,
    required Function callback,
    required List<Map<String, dynamic>> listaCategorias,
  })  : _callback = callback,
        _listaCategorias = listaCategorias;

  final Function _callback;

  final List<Map<String, dynamic>> _listaCategorias;

  @override
  State<ListaCategoriaSenhaWidget> createState() =>
      _ListaCategoriaSenhaWidgetState();
}

class _ListaCategoriaSenhaWidgetState extends State<ListaCategoriaSenhaWidget> {
  List<String> listaSelecionadas = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark;

        return Wrap(
          runSpacing: 16,
          spacing: 8,
          children: [
            for (var item in widget._listaCategorias)
              GestureDetector(
                onTap: () => widget._callback(),
                child: Container(
                  height: UiTamanho.categoria,
                  decoration: BoxDecoration(
                    color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                  child: TextoText(texto: item['textoCategoria']),
                ),
              ),
          ],
        );
      },
    );
  }
}
