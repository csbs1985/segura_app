import 'package:flutter/material.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/theme/ui_botao.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/theme/ui_tema.dart';
import 'package:senha_app/theme/ui_texto.dart';

class PadraoSelecionarWidget extends StatefulWidget {
  const PadraoSelecionarWidget({
    super.key,
    required Function? callback,
  }) : _callback = callback;

  final Function? _callback;

  @override
  _PadraoSelecionarWidgetState createState() => _PadraoSelecionarWidgetState();
}

class _PadraoSelecionarWidgetState extends State<PadraoSelecionarWidget> {
  List<String> listaSelecionado = [GerarSenhaEnum.MINUSCULA.name];

  void _selecionarCategoria(String value) {
    setState(() {
      listaSelecionado.contains(value)
          ? listaSelecionado.remove(value)
          : listaSelecionado.add(value);
    });

    widget._callback!(listaSelecionado);
  }

  bool isCategoriaSelecionada(String value) {
    return listaSelecionado.contains(value) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                for (var item in listaGeradorSenha)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                    child: SizedBox(
                      height: UiTamanho.tag,
                      child: TextButton(
                        onPressed: () => _selecionarCategoria(item.value),
                        style: isCategoriaSelecionada(item.value)
                            ? UiBotao.tagAtivo
                            : isEscuro
                                ? UiBotao.tagEscuro
                                : UiBotao.tag,
                        child: Text(
                          item.texto,
                          style: isCategoriaSelecionada(item.value)
                              ? UiTexto.tagAtiva
                              : isEscuro
                                  ? UiTexto.tagEscuro
                                  : UiTexto.tag,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
