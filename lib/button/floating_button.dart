import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_size.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({
    super.key,
    required Function callback,
    required IconData icon,
  })  : _callback = callback,
        _icon = icon;

  final Function _callback;
  final IconData _icon;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget._callback(),
      child: SizedBox(
        width: UiSize.inputButton,
        height: UiSize.inputButton,
        child: Container(
          width: UiSize.inputButton,
          height: UiSize.inputButton,
          decoration: BoxDecoration(
            color: UiColor.primary,
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          child: Icon(
            widget._icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
