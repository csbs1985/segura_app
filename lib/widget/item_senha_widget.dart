import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/favicon_widget.dart';
import 'package:senha_app/widget/iniciais_widgte.dart';

class ItemSenhaWidget extends StatelessWidget {
  const ItemSenhaWidget({
    super.key,
    required Map<String, dynamic> item,
    required Function onTap,
    required Function onLongPress,
  })  : _item = item,
        _onTap = onTap,
        _onLongPress = onLongPress;

  final Map<String, dynamic> _item;
  final Function _onTap;
  final Function _onLongPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: UiTamanho.itemLista),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiBorda.arredondada),
        onLongPress: () => _onLongPress(),
        onTap: () => _onTap(),
        child: ValueListenableBuilder(
          valueListenable: currentLayout,
          builder: (BuildContext context, bool isLayoutAberto, _) {
            return AnimatedContainer(
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
                border: Border.all(
                  color: Theme.of(context).colorScheme.tertiary,
                  width: 1,
                ),
              ),
              padding: !isLayoutAberto
                  ? const EdgeInsets.fromLTRB(16, 8, 16, 8)
                  : const EdgeInsets.fromLTRB(16, 12, 16, 12),
              duration: const Duration(milliseconds: 500),
              child: Row(
                crossAxisAlignment: !isLayoutAberto
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: !isLayoutAberto ? 0 : 4),
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
                        !isLayoutAberto
                            ? Container()
                            : Column(
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
