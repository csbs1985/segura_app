import 'package:flutter/material.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/copy_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/model/note_modal.dart';
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

  bool _isNote(NoteModel note) {
    return (note.note.isNotEmpty) ? true : false;
  }

  _isCopy() {
    return (widget._note['note'].isNotEmpty) ? true : false;
  }

  _copyNote() {
    _copyClass.copy(
      context: context,
      text: widget._note['note'],
    );
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
      child: ValueListenableBuilder(
        valueListenable: currentNote,
        builder: (BuildContext context, NoteModel note, _) {
          return Wrap(
            spacing: 8,
            children: [
              // Text(widget._note['note']),
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
              if (_isNote(note))
                SvgButton(
                  icon: UniconsLine.trash_alt,
                  callback: () => _deleteNote(context),
                ),
              if (_isCopy())
                SvgButton(
                  icon: UniconsLine.copy,
                  callback: () => _copyNote(),
                ),
            ],
          );
        },
      ),
    );
  }
}
