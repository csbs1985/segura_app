import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({
    super.key,
    required Function callback,
    required bool value,
  })  : _callback = callback,
        _value = value;

  final Function _callback;
  final bool _value;

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = theme == Brightness.dark;

        return FlutterSwitch(
          width: UiTamanho.toggleLargura,
          height: UiTamanho.toggleAltura,
          value: widget._value,
          activeColor: UiCor.segunda,
          inactiveColor: isDark ? UiCor.toogleEscuro : UiCor.toogle,
          activeToggleColor: UiCor.primeira,
          inactiveToggleColor: UiCor.primeira,
          toggleSize: UiTamanho.toggleTamanho,
          onToggle: (value) => widget._callback(value),
        );
      },
    );
  }
}
