import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/pesquisa_vazia_widget.dart';
import 'package:senha_app/widget/senha_item_widget.dart';

class PesquisarWidget extends StatelessWidget {
  const PesquisarWidget({
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
                return SenhaItemWidget(senha: _senha[index]);
              },
            ),
    );
  }
}
