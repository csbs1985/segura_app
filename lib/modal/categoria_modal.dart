import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/appbar/modal_appbar.dart';
import 'package:senha_app/button/segundo_button.dart';
import 'package:senha_app/class/categoria_class.dart';
import 'package:senha_app/component/categoria_component.dart';
import 'package:senha_app/modal/categoria_form_modal.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:unicons/unicons.dart';

class CategoriaModal extends StatefulWidget {
  const CategoriaModal({super.key});

  @override
  State<CategoriaModal> createState() => _CategoriaModalState();
}

class _CategoriaModalState extends State<CategoriaModal> {
  final List<dynamic> _listaCategorias = [];

  void _abrirCategoriaFormModal(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => CategoriaFormModal(selecionado: item),
    );
  }

  void _selecionarCategoria(Map<String, dynamic> _categoria) {
    _listaCategorias.contains(_categoria['idCategoria'])
        ? _listaCategorias.remove(_categoria['idCategoria'])
        : _listaCategorias.add(_categoria['idCategoria']);
  }

  void _salvarSenha(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModalAppbar(),
      body: CategoriaComponent(
        route: CategoriaRouteEnum.MODAL,
        onLongPress: (value) => _abrirCategoriaFormModal(context, value),
        onTap: (value) => _selecionarCategoria(value),
      ),
      floatingActionButton: SegundoButton(
        callback: () => _salvarSenha(context),
        icone: UniconsLine.check,
      ),
    );
  }
}
