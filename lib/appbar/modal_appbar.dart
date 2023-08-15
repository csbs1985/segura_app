import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';

class ModalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ModalAppBar({
    super.key,
    bool? isAdd = false,
    Function? callback,
    bool? isCheck = true,
    required String text,
  })  : _callback = callback,
        _isCheck = isCheck,
        _isAdd = isAdd,
        _text = text;

  final bool? _isAdd;
  final Function? _callback;
  final bool? _isCheck;
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
        if (_isAdd == true)
          SvgButton(
            icon: Icons.add,
            callback: () => _callback!(),
          ),
        if (_isCheck == true)
          SvgButton(
            icon: Icons.check,
            callback: () => context.pop(),
          ),
      ],
    );
  }
}
