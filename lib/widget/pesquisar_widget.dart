import 'package:flutter/material.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/mensagem_text.dart';
import 'package:senha_app/widget/senha_item_widget.dart';

class PesquisarWidget extends StatelessWidget {
  const PesquisarWidget({
    super.key,
    required List<Map<String, dynamic>> senha,
  }) : _senha = senha;

  final List<Map<String, dynamic>> _senha;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: _senha.isEmpty
          ? const MensagemText(texto: PESQUISAR_VAZIO)
          : ListView.builder(
              itemCount: _senha.length,
              itemBuilder: (BuildContext context, int index) {
                return SenhaItemWidget(senha: _senha[index]);
              },
            ),
    );
  }
}
