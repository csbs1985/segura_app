import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/hive/layout_hive.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class LayoutButton extends StatefulWidget {
  const LayoutButton({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<LayoutButton> createState() => _LayoutButtonState();
}

class _LayoutButtonState extends State<LayoutButton> {
  final LayoutHive _layoutHive = LayoutHive();

  bool _isLista = true;

  @override
  void initState() {
    _isLista = _layoutHive.receberLayout();
    super.initState();
  }

  void _toggleLayout() {
    setState(() => _isLista = !_isLista);
    _layoutHive.salvarLayout(_isLista);
    currentLayout.value = _isLista;
    widget._callback();
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
              _isLista ? Icons.view_agenda_outlined : Icons.crop_square,
              color: isEscuro ? UiCor.iconeEscuro : UiCor.icone,
            ),
            onTap: () => _toggleLayout(),
          ),
        );
      },
    );
  }
}
