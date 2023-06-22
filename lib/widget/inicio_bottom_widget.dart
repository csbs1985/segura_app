import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/modal/categoria_modal.dart';
import 'package:senha_app/modal/copiar_modal.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:unicons/unicons.dart';

class InicioBottomWidget extends StatelessWidget {
  final SenhaClass _senhaClass = SenhaClass();

  InicioBottomWidget({
    super.key,
    required Map<String, dynamic> senha,
  }) : _senha = senha;

  final Map<String, dynamic> _senha;

  @override
  Widget build(BuildContext context) {
    void _abrirCategoriaModal() {
      showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        barrierColor: UiCor.overlay,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (context) => const CategoriaModal(),
      );
    }

    void _modalCopiar(BuildContext context) {
      Map<String, dynamic> _copiar = {
        'anotacao': _senha['anotacao'],
        'link': _senha['link'],
        'nome': _senha['nome'],
        'senha': _senha['senha'],
        'usuario': _senha['usuario'],
      };

      showCupertinoModalBottomSheet(
        context: context,
        barrierColor: UiCor.overlay,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (context) => CopiarModal(copiar: _copiar),
      );
    }

    bool _verificarCopiar() {
      if (_senha['anotacao'] != "" ||
          _senha['link'] != "" ||
          _senha['anonometacao'] != "" ||
          _senha['senha'] != "" ||
          _senha['usuario'] != "") return true;

      return false;
    }

    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark ? true : false;

        return Material(
          color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
          child: Row(
            children: [
              IconeButton(
                icone: UniconsLine.label,
                callback: () => _abrirCategoriaModal(),
              ),
              IconeButton(
                icone: UniconsLine.user_plus,
                callback: () => {},
              ),
              if (_verificarCopiar())
                IconeButton(
                  icone: UniconsLine.copy,
                  callback: () => _modalCopiar(context),
                ),
            ],
          ),
        );
      },
    );
  }
}
