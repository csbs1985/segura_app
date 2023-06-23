import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/appbar/modal_appbar.dart';
import 'package:senha_app/button/floating_button.dart';
import 'package:senha_app/class/categoria_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/firestore/categoria_firestore.dart';
import 'package:senha_app/modal/categoria_form_modal.dart';
import 'package:senha_app/skeleton/cateroria_skeleton%20copy.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/lista_categoria_modal_widget.dart';
import 'package:unicons/unicons.dart';

class CategoriaModal extends StatefulWidget {
  const CategoriaModal({super.key});

  @override
  State<CategoriaModal> createState() => _CategoriaModalState();
}

class _CategoriaModalState extends State<CategoriaModal> {
  final CategoriaClass _categoriaClass = CategoriaClass();
  final CategoriaFirestore _categoriaFirestore = CategoriaFirestore();

  final List<dynamic> _listaCategorias = [];

  void _abrirModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const CategoriaFormModal(),
    );
  }

  void _selecionarCategoria(String _idCategoria) {
    _listaCategorias.contains(_idCategoria)
        ? _listaCategorias.remove(_idCategoria)
        : _listaCategorias.add(_idCategoria);
  }

  void _salvarSenha(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModalAppbar(),
      body: ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isEscuro = tema == Brightness.dark;

          return SingleChildScrollView(
            child: Container(
              color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubtituloText(texto: CATEGORIAS),
                      const SizedBox(height: 16),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream:
                            _categoriaFirestore.receberTodasCategoriasUsuario(
                          currentUsuario.value.idUsuario,
                        ),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot,
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
                                      snapshot.data?.docs);

                              if (_listaCategorias.isNotEmpty) {
                                return ValueListenableBuilder(
                                    valueListenable: currentCategorias,
                                    builder: (BuildContext context,
                                        List<Map<String, dynamic>> categorias,
                                        _) {
                                      return ListaCategoriaModalWidget(
                                        listaSelecionadas: const [],
                                        callback: (value) =>
                                            _selecionarCategoria(value),
                                      );
                                    });
                              } else {
                                return const TextoText(texto: CATEGORIA_VAZIO);
                              }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingButton(
        callback: () => _abrirModal(context),
        icone: UniconsLine.check,
      ),
    );
  }
}
