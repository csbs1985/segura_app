import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:unicons/unicons.dart';

class ModalAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const ModalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SvgButton(
        icon: UniconsLine.times,
        callback: () => context.pop(),
      ),
    );
  }
}
