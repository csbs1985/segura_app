import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class LayoutButton extends StatefulWidget {
  const LayoutButton({
    super.key,
  });

  @override
  State<LayoutButton> createState() => _LayoutButtonState();
}

class _LayoutButtonState extends State<LayoutButton> {
  bool _isAberto = false;

  void _toggleLayout() {
    setState(() => _isAberto = !_isAberto);
    currentLayout.value = _isAberto;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark;

        return SizedBox(
          width: UiTamanho.iconeLayoput,
          height: UiTamanho.iconeLayoput,
          child: GestureDetector(
            child: Icon(
              _isAberto ? Icons.crop_din_outlined : Icons.view_agenda_outlined,
              color: isEscuro ? UiCor.iconeEscuro : UiCor.icone,
            ),
            onTap: () => _toggleLayout(),
          ),
        );
      },
    );
  }
}
