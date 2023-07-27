import 'package:flutter/material.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/texto_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/legenda_text.dart';
import 'package:senha_app/theme/ui_cor.dart';

class InicioBottomWidget extends StatelessWidget {
  final SenhaClass _senhaClass = SenhaClass();
  final TextoClass _textoClass = TextoClass();

  InicioBottomWidget({
    super.key,
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark ? true : false;

        return Material(
          color: isEscuro ? UiCor.backgroundEscuro : UiCor.background,
          child: _textoClass.validarVariavel(_item['dataRegistro'])
              ? Row(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      child: LegendaText(
                        texto: _senhaClass.ultimaEdicao(_item['dataRegistro']),
                      ),
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
