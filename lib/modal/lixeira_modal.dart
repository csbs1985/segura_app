import 'package:flutter/material.dart';
import 'package:senha_app/button/modal_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:unicons/unicons.dart';

class LixeiraModal extends StatefulWidget {
  const LixeiraModal({
    super.key,
    String? idSenha,
    required List<String> listaSenha,
  })  : _idSenha = idSenha,
        _listaSenha = listaSenha;

  final String? _idSenha;
  final List<String> _listaSenha;

  @override
  State<LixeiraModal> createState() => _LixeiraModalState();
}

class _LixeiraModalState extends State<LixeiraModal> {
  final SenhaClass _senhaClass = SenhaClass();

  List<String> listaSenha = [];

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
                  const SubtituloText(texto: LIXEIRA),
                  const SizedBox(height: 16),
                  const TextoText(texto: RESULTADO_VAZIO),
                  const SizedBox(height: 16),
                  if (widget._idSenha != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModalButton(
                          texto: LIXEIRA_RESTAURAR_ITEM,
                          icone: UniconsLine.history,
                          callback: () => _senhaClass.senhaDeletadaFalse(
                              context, widget._idSenha!),
                        ),
                        const SizedBox(height: UiTamanho.espacoLista),
                        ModalButton(
                          texto: LIXEIRA_DEFINITIVAMENTE,
                          icone: UniconsLine.trash_alt,
                          callback: () => _senhaClass.excluirSenha(
                              context, widget._idSenha!),
                        ),
                        const SizedBox(height: UiTamanho.espacoLista),
                      ],
                    ),
                  Column(
                    children: [
                      ModalButton(
                        texto: LIXEIRA_RESTAURAR,
                        icone: UniconsLine.history,
                        callback: () => _senhaClass.restaurarLixeira(
                            context, widget._listaSenha),
                      ),
                      const SizedBox(height: UiTamanho.espacoLista),
                      ModalButton(
                        texto: LIXEIRA_LIMPAR,
                        icone: UniconsLine.trash_alt,
                        callback: () => _senhaClass.esvaziarLixeira(
                            context, widget._listaSenha),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
