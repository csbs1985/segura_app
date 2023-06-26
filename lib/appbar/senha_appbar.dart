import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/texto_class.dart';
import 'package:senha_app/modal/categoria_modal.dart';
import 'package:senha_app/modal/copiar_modal.dart';
import 'package:senha_app/modal/gerar_senha_modal.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:unicons/unicons.dart';

class SenhaAppbar extends StatefulWidget implements PreferredSizeWidget {
  const SenhaAppbar({
    super.key,
    required Function callback,
    required Map<String, dynamic> senha,
  })  : _callback = callback,
        _senha = senha;

  final Function _callback;
  final Map<String, dynamic> _senha;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<SenhaAppbar> createState() => _SenhaAppbarState();
}

class _SenhaAppbarState extends State<SenhaAppbar> {
  final SenhaClass _senhaClass = SenhaClass();
  final TextoClass _textoClass = TextoClass();

  void _abrirCategoriaModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const CategoriaModal(),
    );
  }

  void _abrirCopiarModal(BuildContext context) {
    Map<String, dynamic> _copiar = {
      'anotacao': widget._senha['anotacao'],
      'link': widget._senha['link'],
      'nome': widget._senha['nome'],
      'senha': widget._senha['senha'],
      'usuario': widget._senha['usuario'],
    };

    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => CopiarModal(copiar: _copiar),
    );
  }

  _abrirGeradorModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      backgroundColor: Colors.red,
      builder: (context) => GerarSenhaModal(
        callback: (value) => {
          Navigator.of(context).pop(),
          setState(
            () => {
              widget._senha['senha'] = value,
              widget._callback(widget._senha),
            },
          ),
        },
      ),
    );
  }

  bool _verificarCopiar() {
    if (_textoClass.validarVariavel(widget._senha['anotacao']) ||
        _textoClass.validarVariavel(widget._senha['link']) ||
        _textoClass.validarVariavel(widget._senha['anonometacao']) ||
        _textoClass.validarVariavel(widget._senha['senha']) ||
        _textoClass.validarVariavel(widget._senha['usuario'])) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconeButton(
        icone: UniconsLine.arrow_left,
        callback: () => Navigator.of(context).pop(),
      ),
      actions: [
        if (_textoClass.validarVariavel(widget._senha['dataRegistro']))
          IconeButton(
            icone: UniconsLine.trash_alt,
            callback: () => _senhaClass.senhaDeletadaTrue(
              context,
              widget._senha['idSenha'],
            ),
          ),
        if (_verificarCopiar())
          IconeButton(
            icone: UniconsLine.copy,
            callback: () => _abrirCopiarModal(context),
          ),
        IconeButton(
          icone: UniconsLine.asterisk,
          callback: () => _abrirGeradorModal(context),
        ),
        IconeButton(
          icone: UniconsLine.label,
          callback: () => _abrirCategoriaModal(context),
        ),
        IconeButton(
          icone: UniconsLine.user_plus,
          callback: () => {},
        ),
      ],
    );
  }
}
