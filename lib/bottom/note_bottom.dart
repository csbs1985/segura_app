import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/copy_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:unicons/unicons.dart';

class NoteBottom extends StatefulWidget {
  const NoteBottom({
    super.key,
    required Function callback,
    required Map<String, dynamic> note,
  })  : _callback = callback,
        _note = note;

  final Function _callback;
  final Map<String, dynamic> _note;

  @override
  State<NoteBottom> createState() => _NoteBottomState();
}

class _NoteBottomState extends State<NoteBottom> {
  final CopyClass _copyClass = CopyClass();
  final NoteClass _noteClass = NoteClass();

  bool _isCopy() {
    return (widget._note['note'].isNotEmpty) ? true : false;
  }

  _copyNote() {
    _copyClass.copy(
      context: context,
      text: widget._note['note'],
    );
  }

  _deleteNote(BuildContext context) {
    widget._note['noteId'] != ""
        ? _noteClass.noteExcludedTrue(context, currentNote.value.noteId)
        : context.pop();
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
