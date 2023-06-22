import 'package:flutter/material.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class PrimeirolButton extends StatefulWidget {
  const PrimeirolButton({
    super.key,
    required Function callback,
    required String texto,
    double? width = 0,
  })  : _callback = callback,
        _texto = texto,
        _width = width;

  final Function _callback;
  final String _texto;
  final double? _width;

  @override
  State<PrimeirolButton> createState() => _PrimeirolButtonState();
}

class _PrimeirolButtonState extends State<PrimeirolButton> {
  final double _height = UiTamanho.botao;

  double _widtht = 0;

  late double _position = UiTamanho.botaoBorda;

  @override
  Widget build(BuildContext context) {
    _widtht = widget._width! ?? MediaQuery.sizeOf(context).width - (2 * 16);

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
                decoration: const BoxDecoration(
                  color: UiCor.terceira,
                  borderRadius: BorderRadius.all(
                    Radius.circular(UiBorda.arredondada),
                  ),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: UiCor.segunda,
                  borderRadius: BorderRadius.all(
                    Radius.circular(UiBorda.arredondada),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget._texto.toUpperCase(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTapUp: (_) {
        setState(() {
          _position = UiTamanho.botaoBorda;
          widget._callback(true);
        });
      },
      onTapDown: (_) {
        setState(() => _position = 0);
      },
      onTapCancel: () {
        setState(() => _position = UiTamanho.botaoBorda);
      },
    );
  }
}
