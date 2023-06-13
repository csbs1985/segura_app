import 'package:flutter/material.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/theme/ui_tema.dart';
import 'package:senha_app/widget/favicon_widget.dart';
import 'package:senha_app/widget/iniciais_widgte.dart';

class ItemListaWidget extends StatelessWidget {
  const ItemListaWidget({
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
          valueListenable: currentTema,
          builder: (BuildContext context, Brightness tema, _) {
            bool isEscuro = tema == Brightness.dark;

            return Container(
              decoration: BoxDecoration(
                color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _item["link"] != ""
                      ? FaviconWidget(url: _item["link"])
                      : IniciaisWidget(texto: _item["nome"]),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextoText(texto: _item["nome"]),
                        if (!_item["oculto"])
                          SubtituloText(texto: _item["senha"]),
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
