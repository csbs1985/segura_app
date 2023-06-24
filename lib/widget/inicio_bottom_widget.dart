import 'package:flutter/material.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/legenda_text.dart';
import 'package:senha_app/theme/ui_cor.dart';

class InicioBottomWidget extends StatelessWidget {
  final SenhaClass _senhaClass = SenhaClass();

  InicioBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark ? true : false;

        return Material(
          color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
          child: Row(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 32,
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: LegendaText(
                  texto: _senhaClass
                      .ultimaEdicao(currentForm.value['dataRegistro']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
