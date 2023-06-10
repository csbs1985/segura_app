import 'package:flutter/material.dart';
import 'package:senha_app/button/modal_button.dart';
import 'package:senha_app/class/copiar_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/theme/ui_tema.dart';
import 'package:unicons/unicons.dart';

class CopiarModal extends StatefulWidget {
  const CopiarModal({
    super.key,
    required Map<String, dynamic> copiar,
  }) : _copiar = copiar;

  final Map<String, dynamic> _copiar;

  @override
  State<CopiarModal> createState() => _CopiarModalState();
}

class _CopiarModalState extends State<CopiarModal> {
  final CopiarClass _copiarClass = CopiarClass();

  List<String> copiar = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return SingleChildScrollView(
          child: Container(
            color: isDark ? UiCor.fundoEscuro : UiCor.fundo,
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubtituloText(texto: COPIAR),
                    SizedBox(height: 16),
                    TextoText(texto: COPIAR_DESCRICAO),
                    SizedBox(height: 16),
                  ],
                ),
                if (widget._copiar['nome'] != "")
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: UiTamanho.espacoLista),
                    child: ModalButton(
                      texto: COPIAR_NOME,
                      icone: UniconsLine.copy,
                      callback: () => _copiarClass.copiar(
                        context: context,
                        texto: widget._copiar['nome'],
                        voltar: true,
                      ),
                    ),
                  ),
                if (widget._copiar['link'] != "")
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: UiTamanho.espacoLista),
                    child: ModalButton(
                      texto: COPIAR_LINK,
                      icone: UniconsLine.copy,
                      callback: () => _copiarClass.copiar(
                        context: context,
                        texto: widget._copiar['link'],
                        voltar: true,
                      ),
                    ),
                  ),
                if (widget._copiar['usuario'] != "")
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: UiTamanho.espacoLista),
                    child: ModalButton(
                      texto: COPIAR_USUARIO,
                      icone: UniconsLine.copy,
                      callback: () => _copiarClass.copiar(
                        context: context,
                        texto: widget._copiar['usuario'],
                        voltar: true,
                      ),
                    ),
                  ),
                if (widget._copiar['senha'] != "")
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: UiTamanho.espacoLista),
                    child: ModalButton(
                      texto: COPIAR_SENHA,
                      icone: UniconsLine.copy,
                      callback: () => _copiarClass.copiar(
                        context: context,
                        texto: widget._copiar['senha'],
                        voltar: true,
                      ),
                    ),
                  ),
                if (widget._copiar['anotacao'] != "")
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: UiTamanho.espacoLista),
                    child: ModalButton(
                      texto: COPIAR_ANOTACAO,
                      icone: UniconsLine.copy,
                      callback: () => _copiarClass.copiar(
                        context: context,
                        texto: widget._copiar['anotacao'],
                        voltar: true,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
