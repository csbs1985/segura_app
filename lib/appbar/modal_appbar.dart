import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:unicons/unicons.dart';

class ModalAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const ModalAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconeButton(
        callback: () => Navigator.of(context).pop(),
        icone: UniconsLine.times,
      ),
    );
  }
}
