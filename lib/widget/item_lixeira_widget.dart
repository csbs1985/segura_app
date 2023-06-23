import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/modal/lixeira_modal.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/favicon_widget.dart';
import 'package:senha_app/widget/iniciais_widgte.dart';

class ItemLixeiraWidget extends StatelessWidget {
  const ItemLixeiraWidget({
    super.key,
    required Map<String, dynamic> item,
  }) : _item = item;

  final Map<String, dynamic> _item;

  void _abrirModal(BuildContext context, String idSenha) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => LixeiraModal(
        idSenha: idSenha,
        listaSenha: const [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: UiTamanho.itemLista),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiBorda.arredondada),
        onLongPress: () => _abrirModal(context, _item["idSenha"]),
        onTap: () => context.pushNamed(
          RoutesEnum.SENHA.value,
          pathParameters: {'idSenha': _item['idSenha']},
        ),
        child: ValueListenableBuilder(
          valueListenable: currentTema,
          builder: (BuildContext context, Brightness tema, _) {
            bool isEscuro = tema == Brightness.dark;

            return AnimatedContainer(
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              duration: const Duration(milliseconds: 500),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: _item["link"] != ""
                        ? FaviconWidget(url: _item["link"])
                        : IniciaisWidget(texto: _item["nome"]),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextoText(texto: _item["nome"]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: SubtituloText(texto: _item["senha"]),
                            ),
                            if (_item["link"] != "")
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextoText(texto: _item["link"]),
                              ),
                            if (_item["usuario"] != "")
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextoText(texto: _item["usuario"]),
                              ),
                            if (_item["anotacao"] != "")
                              TextoText(texto: _item["anotacao"]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
