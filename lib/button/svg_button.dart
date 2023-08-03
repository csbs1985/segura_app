import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_size.dart';

class SvgButton extends StatefulWidget {
  const SvgButton({
    super.key,
    required Function callback,
    required IconData icon,
  })  : _callback = callback,
        _icone = icon;

  final Function _callback;
  final IconData _icone;

  @override
  State<SvgButton> createState() => _SvgButtonState();
}

class _SvgButtonState extends State<SvgButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UiSize.icon,
      height: UiSize.icon,
      child: InkWell(
        borderRadius: BorderRadius.circular(UiBorder.circle),
        child: Icon(
          widget._icone,
          color: Theme.of(context).iconTheme.color,
        ),
        onTap: () => widget._callback(),
      ),
    );
  }
}
