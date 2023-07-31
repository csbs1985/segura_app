import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_size.dart';

class ListButton extends StatefulWidget {
  const ListButton({
    super.key,
    required Function callback,
    required String text,
    required IconData icon,
  })  : _callback = callback,
        _icon = icon,
        _text = text;

  final Function _callback;
  final String _text;
  final IconData _icon;

  @override
  State<ListButton> createState() => _ListButtonState();
}

class _ListButtonState extends State<ListButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget._callback(),
      child: Container(
        width: double.infinity,
        height: UiSize.appbar,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        child: Row(
          children: [
            Icon(widget._icon),
            const SizedBox(width: 16),
            Text(
              widget._text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
