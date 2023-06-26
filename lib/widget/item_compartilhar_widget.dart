import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/widget/avatar_widget.dart';
import 'package:unicons/unicons.dart';

class ItemCompartilharWidget extends StatefulWidget {
  const ItemCompartilharWidget({
    super.key,
    required bool isAdicionar,
    required Map<String, dynamic> usuario,
  })  : _isAdicionar = isAdicionar,
        _usuario = usuario;

  final bool _isAdicionar;
  final Map<String, dynamic> _usuario;

  @override
  State<ItemCompartilharWidget> createState() => _ItemCompartilharWidgetState();
}

class _ItemCompartilharWidgetState extends State<ItemCompartilharWidget> {
  void _adicionarCompartilhar(BuildContext context) {}

  void _removerCompartilhar(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AvatarWidget(avatar: widget._usuario['avatarUsuario']),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextoText(texto: widget._usuario['nomeUsuario']),
              TextoText(texto: widget._usuario['emailUsuario']),
            ],
          ),
        ),
        IconeButton(
          callback: () => widget._isAdicionar
              ? _adicionarCompartilhar(context)
              : _removerCompartilhar(context),
          icone: widget._isAdicionar ? UniconsLine.plus : UniconsLine.times,
        )
      ],
    );
  }
}
