import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/list_button.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:unicons/unicons.dart';

class CategoryModal extends StatefulWidget {
  const CategoryModal({
    super.key,
    required String noteId,
  }) : _noteId = noteId;

  final String _noteId;

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  final NoteClass _noteClass = NoteClass();

  void _deleteNote(BuildContext context) {
    context.pop();
    _noteClass.deleteNoteCloud(context, widget._noteId);
  }

  void _restoreNote(BuildContext context) {
    context.pop();
    _noteClass.noteExcludedFalse(context, widget._noteId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListButton(
              text: RESTORE,
              icon: UniconsLine.history,
              callback: () => _restoreNote(context),
            ),
            const SizedBox(height: UiSize.spaceList),
            ListButton(
              text: DELETE_EVER,
              icon: UniconsLine.trash,
              callback: () => _deleteNote(context),
            ),
          ],
        ),
      ),
    );
  }
}
