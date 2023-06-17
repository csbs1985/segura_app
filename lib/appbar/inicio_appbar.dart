import 'package:flutter/material.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/avatar_widget.dart';
import 'package:senha_app/widget/padrao_input.dart';

class InicioAppbar extends StatelessWidget {
  const InicioAppbar({
    super.key,
    required Function avatar,
    required Function pesquisar,
  })  : _avatar = avatar,
        _pesquisar = pesquisar;

  final Function _avatar;
  final Function _pesquisar;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark;
        return Container(
          decoration: BoxDecoration(
            color: isEscuro ? UiCor.inputEscuro : UiCor.input,
            borderRadius: BorderRadius.circular(UiBorda.circulo),
            border: Border.all(
              color: isEscuro ? UiCor.bordaEscura : UiCor.borda,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: PadraoInput(
                  callback: (value) => _pesquisar(value),
                  hintText: PESQUISAR,
                  pesquisarIcone: true,
                  inputCircular: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: GestureDetector(
                  onTap: () => _avatar(),
                  child: const AvatarWidget(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
