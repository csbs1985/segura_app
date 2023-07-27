import 'package:flutter/material.dart';
import 'package:senha_app/button/layout_button.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(UiBorda.circulo),
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
          const LayoutButton(),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
            child: GestureDetector(
              onTap: () => _avatar(),
              child: const AvatarButton(),
            ),
          ),
        ],
      ),
    );
  }
}
