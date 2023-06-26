import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senha_app/class/categoria_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/firestore/categoria_firestore.dart';
import 'package:senha_app/skeleton/cateroria_skeleton%20copy.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class CategoriaComponent extends StatefulWidget {
  const CategoriaComponent({
    super.key,
    required CategoriaRouteEnum route,
    required Function onTap,
    required Function onLongPress,
  })  : _route = route,
        _onTap = onTap,
        _onLongPress = onLongPress;

  final CategoriaRouteEnum _route;
  final Function _onTap;
  final Function _onLongPress;

  @override
  State<CategoriaComponent> createState() => _CategoriaComponentState();
}

class _CategoriaComponentState extends State<CategoriaComponent> {
  final CategoriaClass _categoriaClass = CategoriaClass();
  final CategoriaFirestore _categoriaFirestore = CategoriaFirestore();

  List<Map<String, dynamic>> _listaSelecionadas = [];

  void _selecionarCategoria(Map<String, dynamic> categoria) {
    widget._route == CategoriaRouteEnum.PAGE
        ? widget._onTap(categoria)
        : _toggleCategoria(categoria['idCategoria']);
  }

  void _toggleCategoria(String _idCategoria) {
    setState(() {
      _listaSelecionadas = _categoriaClass.verificarCategoria(_idCategoria);
      // widget._callback(_listaSelecionadas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubtituloText(texto: CATEGORIAS),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _categoriaFirestore.receberTodasCategoriasUsuario(
                  currentUsuario.value.idUsuario,
                ),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const TextoText(texto: CATEGORIA_VAZIO);
                    case ConnectionState.waiting:
                      return const CategoriaSkeleton();
                    case ConnectionState.done:
                    default:
                      List<Map<String, dynamic>> _listaCategorias =
                          _categoriaClass.converterQuerySnapshotToList(
                              snapshot.data!.docs);

                      if (_listaCategorias.isNotEmpty) {
                        return ValueListenableBuilder(
                          valueListenable: currentTema,
                          builder: (BuildContext context, Brightness tema, _) {
                            bool isEscuro = tema == Brightness.dark;

                            return Wrap(
                              runSpacing: 8,
                              spacing: 8,
                              children: [
                                for (var item in _listaCategorias)
                                  GestureDetector(
                                    onTap: () => _selecionarCategoria(item),
                                    onLongPress: () =>
                                        widget._onLongPress(item),
                                    child: Container(
                                      height: UiTamanho.categoria,
                                      decoration: widget._route ==
                                              CategoriaRouteEnum.PAGE
                                          ? BoxDecoration(
                                              color: isEscuro
                                                  ? UiCor.inputEscuro
                                                  : UiCor.input,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      UiBorda.arredondada),
                                            )
                                          : BoxDecoration(
                                              color: _listaSelecionadas
                                                      .contains(item)
                                                  ? null
                                                  : isEscuro
                                                      ? UiCor.inputEscuro
                                                      : UiCor.input,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      UiBorda.arredondada),
                                              border: Border.all(
                                                color: isEscuro
                                                    ? UiCor.inputEscuro
                                                    : UiCor.input,
                                                width: 2.0,
                                              ),
                                            ),
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 10, 16, 8),
                                      child: TextoText(
                                          texto: item['textoCategoria']),
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      } else
                        return const TextoText(texto: CATEGORIA_VAZIO);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
