import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/modal/categoria_modal.dart';
import 'package:senha_app/text/legenda_text.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:unicons/unicons.dart';

class EditadoWidget extends StatelessWidget {
  final SenhaClass _senhaClass = SenhaClass();

  EditadoWidget({
    super.key,
    required String dataRegistro,
  }) : _dataRegistro = dataRegistro;

  final String _dataRegistro;

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
              // IconeButton(
              //   icone: UniconsLine.user_plus,
              //   callback: () => {},
              // ),
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 32,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: _dataRegistro.isEmpty
                      ? null
                      : LegendaText(
                          texto: _senhaClass.ultimaEdicao(_dataRegistro)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
