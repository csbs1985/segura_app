import 'package:flutter/material.dart';
import 'package:senha_app/class/categoria_class.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class SegundoButton extends StatefulWidget {
  const SegundoButton({
    super.key,
    required Function callback,
    required IconData icone,
    CategoriaButtonEnum? estilo = CategoriaButtonEnum.PRIMARIO,
  })  : _callback = callback,
        _icone = icone,
        _estilo = estilo;

  final Function _callback;
  final IconData _icone;
  final CategoriaButtonEnum? _estilo;

  @override
  State<SegundoButton> createState() => _SegundoButtonState();
}

class _SegundoButtonState extends State<SegundoButton> {
  final double _height = UiTamanho.inputBotao;
  final double _width = UiTamanho.inputBotao;
  late double _position = UiTamanho.botaoBorda;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark ? true : false;

        return GestureDetector(
          child: SizedBox(
            width: _width,
            height: _height + UiTamanho.botaoBorda,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                      color: widget._estilo == CategoriaButtonEnum.PRIMARIO
                          ? UiCor.iconeDestaque
                          : isEscuro
                              ? UiCor.borderEscura
                              : UiCor.border,
                      borderRadius: BorderRadius.circular(UiBorda.arredondada),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeIn,
                  bottom: _position,
                  duration: const Duration(milliseconds: 10),
                  child: Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                      color:
                          isEscuro ? UiCor.backgroundEscuro : UiCor.background,
                      borderRadius: BorderRadius.circular(UiBorda.arredondada),
                      border: Border.all(
                        color: widget._estilo == CategoriaButtonEnum.PRIMARIO
                            ? UiCor.iconeDestaque
                            : isEscuro
                                ? UiCor.borderEscura
                                : UiCor.border,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      widget._icone,
                      color: widget._estilo == CategoriaButtonEnum.PRIMARIO
                          ? UiCor.iconeDestaque
                          : isEscuro
                              ? UiCor.borderEscura
                              : UiCor.border,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTapUp: (_) {
            setState(() {
              _position = UiTamanho.botaoBorda;
              widget._callback();
            });
          },
          onTapDown: (_) {
            setState(() => _position = 0);
          },
          onTapCancel: () {
            setState(() => _position = UiTamanho.botaoBorda);
          },
        );
      },
    );
  }
}
