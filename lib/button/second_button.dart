import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_size.dart';

class SecondButton extends StatefulWidget {
  const SecondButton({
    super.key,
    required Function callback,
    required String text,
  })  : _callback = callback,
        _text = text;

  final Function _callback;
  final String _text;

  @override
  State<SecondButton> createState() => _SecondButtonState();
}

class _SecondButtonState extends State<SecondButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: () => widget._callback(),
      child: Container(
        height: UiSize.secondButton,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: isPressed
              ? UiColor.secondButton.withOpacity(0.2)
              : UiColor.secondButton,
          borderRadius: BorderRadius.circular(UiBorder.rounded),
        ),
        child: Center(
          child: Text(
            widget._text,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ),
    );
  }
}
