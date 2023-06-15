import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/toggle_widget.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required Function callback,
    required String subtitulo,
    required String texto,
    required bool value,
  })  : _subtitulo = subtitulo,
        _texto = texto,
        _callback = callback,
        _value = value;

  final Function _callback;
  final String _subtitulo;
  final String _texto;
  final bool _value;

  @override
  State<ToggleButton> createState() => _ToggleSelecionarWidgetState();
}

class _ToggleSelecionarWidgetState extends State<ToggleButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return GestureDetector(
          // onTapDown: (_) => setState(() => isPressed = true),
          // onTapUp: (_) => setState(() => isPressed = false),
          // onTapCancel: () => setState(() => isPressed = false),
          onTap: () => widget._callback(true),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorda.arredondada),
              border: Border.all(
                color: isDark ? UiCor.bordaEscura : UiCor.borda,
                width: 2.0,
              ),
              color: isPressed
                  ? isDark
                      ? UiCor.fundoEscuro
                      : UiCor.fundo
                  : isDark
                      ? UiCor.inputEscuro
                      : UiCor.input,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtituloText(texto: widget._subtitulo),
                      const SizedBox(height: 8),
                      TextoText(texto: widget._texto),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ToggleWidget(
                  value: widget._value,
                  callback: (value) => widget._callback(value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
