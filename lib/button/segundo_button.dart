import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class SegundolButton extends StatefulWidget {
  const SegundolButton({
    super.key,
    required Function callback,
    required IconData icone,
  })  : _callback = callback,
        _icone = icone;

  final Function _callback;
  final IconData _icone;

  @override
  State<SegundolButton> createState() => _SegundolButtonState();
}

class _SegundolButtonState extends State<SegundolButton> {
  final double _height = UiTamanho.inputBotao;
  final double _widtht = UiTamanho.inputBotao;
  late double _position = UiTamanho.botaoBorda;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark ? true : false;

        return GestureDetector(
          child: SizedBox(
            width: _widtht,
            height: _height + UiTamanho.botaoBorda,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: _widtht,
                    height: _height,
                    decoration: BoxDecoration(
                      color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                      borderRadius: BorderRadius.circular(UiBorda.arredondada),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeIn,
                  bottom: _position,
                  duration: const Duration(milliseconds: 10),
                  child: Container(
                    width: _widtht,
                    height: _height,
                    decoration: BoxDecoration(
                      color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
                      borderRadius: BorderRadius.circular(UiBorda.arredondada),
                      border: Border.all(
                        color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                        width: 2.0,
                      ),
                    ),
                    child: Icon(
                      widget._icone,
                      color: isEscuro ? UiCor.iconeEscuro : UiCor.icone,
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
