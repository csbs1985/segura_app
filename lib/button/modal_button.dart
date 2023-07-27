import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';

class ModalButton extends StatefulWidget {
  const ModalButton({
    Key? key,
    required this.callback,
    required this.texto,
    required this.icone,
  }) : super(key: key);

  final Function callback;
  final IconData icone;
  final String texto;

  @override
  State<ModalButton> createState() => _ModalButtonState();
}

class _ModalButtonState extends State<ModalButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.callback();
      },
      onTapCancel: () {
        setState(() => isPressed = false);
      },
      child: ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isEscuro = tema == Brightness.dark;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorda.arredondada),
              border: Border.all(
                color: isEscuro ? UiCor.inputEscuro : UiCor.input,
                width: 2.0,
              ),
              color: isPressed
                  ? isEscuro
                      ? UiCor.backgroundEscuro
                      : UiCor.background
                  : (isEscuro ? UiCor.inputEscuro : UiCor.input),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(widget.icone,
                    color: isEscuro ? UiCor.iconEscuro : UiCor.icon),
                const SizedBox(width: 16),
                Expanded(
                  child: TextoText(texto: widget.texto),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
