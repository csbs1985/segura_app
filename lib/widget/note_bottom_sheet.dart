import 'package:flutter/material.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:unicons/unicons.dart';

class NoteBottomSheet extends StatefulWidget {
  const NoteBottomSheet({
    super.key,
    required Function callback,
    required Map<String, dynamic> note,
  })  : _callback = callback,
        _note = note;

  final Function _callback;
  final Map<String, dynamic> _note;

  @override
  State<NoteBottomSheet> createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet> {
  final NoteClass _noteClass = NoteClass();

  _isCopy() {
    return true;
  }

  _openCopyModal(BuildContext context) {}

  _openGeneratorModal(BuildContext context) {}

  _openCategoryModal(BuildContext context) {}

  _openSharedModal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        children: [
          const SizedBox(width: 8),
          SvgButton(
            icon: UniconsLine.trash_alt,
            callback: () =>
                _noteClass.noteExcludedTrue(context, widget._note['noteId']),
          ),
          if (_isCopy())
            SvgButton(
              icon: UniconsLine.copy,
              callback: () => _openCopyModal(context),
            ),
          SvgButton(
            icon: UniconsLine.asterisk,
            callback: () => _openGeneratorModal(context),
          ),
          SvgButton(
            icon: UniconsLine.label,
            callback: () => _openCategoryModal(context),
          ),
          SvgButton(
            icon: UniconsLine.user_plus,
            callback: () => _openSharedModal(context),
          ),
        ],
      ),
    );
  }
}
