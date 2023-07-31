import 'package:flutter/material.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:unicons/unicons.dart';

class NoteAppBar extends StatefulWidget implements PreferredSizeWidget {
  const NoteAppBar({
    super.key,
    required Function callback,
    required Map<String, dynamic> note,
  })  : _callback = callback,
        _note = note;

  final Function _callback;
  final Map<String, dynamic> _note;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<NoteAppBar> createState() => _NoteAppBarState();
}

class _NoteAppBarState extends State<NoteAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: SvgButton(
        icon: UniconsLine.arrow_left,
        callback: () => Navigator.of(context).pop(),
      ),
    );
  }
}
