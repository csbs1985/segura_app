import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/modal/lixeira_modal.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/item_lista_widget.dart';

class LixeiraItemWidget extends StatefulWidget {
  const LixeiraItemWidget({
    super.key,
    required Map<String, dynamic> senha,
  }) : _senha = senha;

  final Map<String, dynamic> _senha;

  @override
  State<LixeiraItemWidget> createState() => _LixeiraItemWidgetState();
}

class _LixeiraItemWidgetState extends State<LixeiraItemWidget> {
  void _abrirModal(BuildContext context, String idSenha) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => LixeiraModal(
        idSenha: idSenha,
        listaSenha: const [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ItemListaWidget(
      item: widget._senha,
      onLongPress: () => _abrirModal(context, widget._senha["idSenha"]),
      onTap: () => context.pushNamed(
        RoutesEnum.SENHA.value,
        pathParameters: {'idSenha': widget._senha['idSenha']},
      ),
    );
  }
}
