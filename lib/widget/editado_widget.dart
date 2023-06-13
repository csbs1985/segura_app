import 'package:flutter/material.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/text/legenda_text.dart';

class EditadoWidget extends StatelessWidget {
  final SenhaClass _senhaClass = SenhaClass();

  EditadoWidget({
    super.key,
    required String dataRegistro,
  }) : _dataRegistro = dataRegistro;

  final String _dataRegistro;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 32,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: [
          if (_dataRegistro != "")
            LegendaText(texto: _senhaClass.ultimaEdicao(_dataRegistro)),
        ],
      ),
    );
  }
}
