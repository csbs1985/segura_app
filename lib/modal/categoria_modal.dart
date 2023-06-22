import 'package:flutter/material.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/theme/ui_cor.dart';

class CategoriaModal extends StatefulWidget {
  const CategoriaModal({
    super.key,
    required String categoria,
  }) : _categoria = categoria;

  final String _categoria;

  @override
  State<CategoriaModal> createState() => _categoriaModalState();
}

class _categoriaModalState extends State<CategoriaModal> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isEscuro = tema == Brightness.dark;

          return SingleChildScrollView(
            child: Container(
              color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtituloText(texto: CATEGORIA_EDITAR),
                      SizedBox(height: 16),
                      SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
