import 'package:flutter/material.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/copy_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/class/validate_class.dart';
import 'package:segura_app/service/value_notifier_service.dart';
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
  final CopyClass _copyClass = CopyClass();
  final NoteClass _noteClass = NoteClass();
  final ValidateClass _validateClass = ValidateClass();

  bool _isNote() {
    // return _validateClass.isValid(widget._note['node']);

    return (widget._note['node'] != null || widget._note['node'] != '')
        ? true
        : false;
  }

  _deleteNote(BuildContext context) {
    _noteClass.noteExcludedTrue(context, currentNote.value.noteId);
  }

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
          if (_isNote())
            SvgButton(
              icon: UniconsLine.trash_alt,
              callback: () => _deleteNote(context),
            ),
          if (_isNote())
            SvgButton(
              icon: UniconsLine.copy,
              callback: () => _copyClass.copy(
                context: context,
                text: widget._note['node'],
              ),
            ),
        ],
      ),
    );
  }
}
