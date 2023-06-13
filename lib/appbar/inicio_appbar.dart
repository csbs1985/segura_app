import 'package:flutter/material.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/padrao_input.dart';

class InicioAppbar extends StatelessWidget {
  const InicioAppbar({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark;
        return Container(
          decoration: BoxDecoration(
            color: isEscuro ? UiCor.inputEscuro : UiCor.input,
            borderRadius: BorderRadius.circular(UiBorda.arredondada),
            border: Border.all(
              color: isEscuro ? UiCor.bordaEscura : UiCor.borda,
              width: 2,
            ),
          ),
          child: PadraoInput(
            callback: (value) => _callback(value),
            hintText: PESQUISAR,
            pesquisar: true,
          ),
        );
      },
    );
  }
}
