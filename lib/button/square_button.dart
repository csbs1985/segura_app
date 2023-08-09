import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_size.dart';

class SquareButton extends StatefulWidget {
  const SquareButton({
    super.key,
    required Function callback,
    required IconData icon,
    required bool isPrimary,
  })  : _callback = callback,
        _icon = icon,
        _isPrimary = isPrimary;

  final Function _callback;
  final IconData _icon;
  final bool _isPrimary;

  @override
  State<SquareButton> createState() => _SquareButtonState();
}

class _SquareButtonState extends State<SquareButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: () => widget._callback(),
      child: Container(
        width: UiSize.button,
        height: UiSize.button,
        decoration: BoxDecoration(
          color: widget._isPrimary
              ? isPressed
                  ? UiColor.primaryButton.withOpacity(0.8)
                  : UiColor.primaryButton
              : isPressed
                  ? Theme.of(context)
                      .chipTheme
                      .backgroundColor!
                      .withOpacity(0.8)
                  : Theme.of(context).chipTheme.backgroundColor,
          borderRadius: BorderRadius.circular(UiBorder.rounded),
        ),
        child: Icon(
          widget._icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
