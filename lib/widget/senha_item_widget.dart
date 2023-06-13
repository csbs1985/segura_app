import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:senha_app/class/copiar_class.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/widget/item_lista_widget.dart';

class SenhaItemWidget extends StatefulWidget {
  const SenhaItemWidget({
    super.key,
    required Map<String, dynamic> senha,
  }) : _senha = senha;

  final Map<String, dynamic> _senha;

  @override
  State<SenhaItemWidget> createState() => _SenhaItemWidgetState();
}

class _SenhaItemWidgetState extends State<SenhaItemWidget> {
  final CopiarClass _copiarClass = CopiarClass();

  @override
  Widget build(BuildContext context) {
    return ItemListaWidget(
      item: widget._senha,
      onLongPress: () =>
          _copiarClass.copiar(context: context, texto: widget._senha["senha"]),
      onTap: () => context.pushNamed(
        RoutesEnum.SENHA.value,
        pathParameters: {'idSenha': widget._senha['idSenha']},
      ),
    );
  }
}
