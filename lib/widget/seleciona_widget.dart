import 'package:flutter/material.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/theme/ui_botao.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/theme/ui_tema.dart';
import 'package:senha_app/theme/ui_texto.dart';

class SelecionarWidget extends StatefulWidget {
  const SelecionarWidget({
    super.key,
    required Function? callback,
    required List<GerarSenhaModel> lista,
  })  : _callback = callback,
        _lista = lista;

  final Function? _callback;
  final List<GerarSenhaModel> _lista;

  @override
  _SelecionarWidgetState createState() => _SelecionarWidgetState();
}

class _SelecionarWidgetState extends State<SelecionarWidget> {
  List<GerarSenhaModel>? listaSelecionado;

  @override
  void initState() {
    listaSelecionado = widget._lista;
    super.initState();
  }

  void _selecionarCategoria(int index) {
    setState(() {
      listaSelecionado![index].selecionado =
          !listaSelecionado![index].selecionado;
      widget._callback!(listaSelecionado);
    });
  }

  bool isCategoriaSelecionada(int index) {
    return listaSelecionado![index].selecionado ? true : false;
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
                for (var item in widget._lista)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                    child: SizedBox(
                      height: UiTamanho.tag,
                      child: TextButton(
                        onPressed: () => _selecionarCategoria(item.index),
                        style: isCategoriaSelecionada(item.index)
                            ? UiBotao.tagAtivo
                            : isEscuro
                                ? UiBotao.tagEscuro
                                : UiBotao.tag,
                        child: Text(
                          item.texto,
                          style: isCategoriaSelecionada(item.index)
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
