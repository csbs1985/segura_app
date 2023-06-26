import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/appbar/voltar_appbar.dart';
import 'package:senha_app/button/floating_button.dart';
import 'package:senha_app/class/categoria_class.dart';
import 'package:senha_app/component/categoria_component.dart';
import 'package:senha_app/modal/categoria_form_modal.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:unicons/unicons.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  void _abrirModal(BuildContext context, Map<String, dynamic> item) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => CategoriaFormModal(selecionado: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: CategoriaComponent(
        route: CategoriaRouteEnum.PAGE,
        onLongPress: (value) => {},
        onTap: (value) => _abrirModal(context, value),
      ),
      floatingActionButton: FloatingButton(
        callback: () => _abrirModal(context, {}),
        icone: UniconsLine.plus,
      ),
    );
  }
}
