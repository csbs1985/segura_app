import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';

class ModalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ModalAppBar({
    super.key,
    required String text,
  }) : _text = text;

  final String _text;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SvgButton(
          icon: Icons.check,
          callback: () => context.pop(),
        ),
      ],
    );
  }
}
