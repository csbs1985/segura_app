import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:unicons/unicons.dart';

class VoltarAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const VoltarAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconeButton(
        icone: UniconsLine.arrow_left,
        callback: () => Navigator.of(context).pop(),
      ),
    );
  }
}
