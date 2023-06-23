import 'package:flutter/material.dart';
import 'package:senha_app/class/categoria_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class ListaCategoriaModalWidget extends StatefulWidget {
  const ListaCategoriaModalWidget({
    super.key,
    required Function callback,
    required List<Map<String, dynamic>> listaSelecionadas,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<ListaCategoriaModalWidget> createState() =>
      _ListaCategoriaModalWidgetState();
}

class _ListaCategoriaModalWidgetState extends State<ListaCategoriaModalWidget> {
  final CategoriaClass _categoriaClass = CategoriaClass();

  List<Map<String, dynamic>> _listaSelecionadas = [];

  @override
  void initState() {
    super.initState();
    for (var item in currentCategorias.value)
      _toggleCategoria(item['idCategoria']);
  }

  void _toggleCategoria(String _categorias) {
    setState(() {
      _listaSelecionadas = _categoriaClass.verificarCategoria(_categorias);
      widget._callback(_listaSelecionadas);
    });
  }

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
            for (var item in _listaSelecionadas)
              GestureDetector(
                onTap: () => _toggleCategoria(item['idCategoria']),
                child: Container(
                  height: UiTamanho.categoria,
                  decoration: BoxDecoration(
                    color: _listaSelecionadas.contains(item)
                        ? null
                        : isEscuro
                            ? UiCor.inputEscuro
                            : UiCor.input,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                    border: Border.all(
                      color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                      width: 2.0,
                    ),
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
