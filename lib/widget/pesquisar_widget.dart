import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:senha_app/class/copiar_class.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/item_senha_widget.dart';
import 'package:senha_app/widget/pesquisa_vazia_widget.dart';

class PesquisarWidget extends StatelessWidget {
  final CopiarClass _copiarClass = CopiarClass();

  PesquisarWidget({
    super.key,
    required List<Map<String, dynamic>> senha,
  }) : _senha = senha;

  final List<Map<String, dynamic>> _senha;

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: UiTamanho.topInicioAppbar),
      child: _senha.isEmpty
          ? PesquisaVaziaWidget(altura: altura)
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _senha.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemSenhaWidget(
                  item: _senha[index],
                  onLongPress: () => _copiarClass.copiar(
                    context: context,
                    mensagem: SENHA_COPIADA,
                    texto: _senha[index]["senha"],
                  ),
                  onTap: () => context.pushNamed(
                    RoutesEnum.SENHA.value,
                    pathParameters: {'idSenha': _senha[index]['idSenha']},
                  ),
                );
              },
            ),
    );
  }
}
