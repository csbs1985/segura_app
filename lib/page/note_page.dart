import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/form_input.dart';
import 'package:segura_app/widget/note_bottom_sheet.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required String type,
  }) : _type = type;

  final String _type;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final NoteClass _noteClass = NoteClass();
  final Uuid _uuid = const Uuid();

  String noteCurrent = "";
  String titleCurrent = "";

  Map<String, dynamic> _noteForm = {};

  @override
  void initState() {
    super.initState();
    _fetchNoteData();
  }

  Future<void> _fetchNoteData() async {
    if (currentNote.value.noteId.isNotEmpty) {
      _noteForm = {
        "category": currentNote.value.category,
        "dateRegistration": currentNote.value.dateRegistration,
        "excluded": currentNote.value.excluded,
        "noteId": currentNote.value.noteId,
        "note": currentNote.value.note,
        "shared": currentNote.value.shared,
        "title": currentNote.value.title,
        "userId": currentNote.value.userId,
      };

      noteCurrent = currentNote.value.note;
      titleCurrent = currentNote.value.title;
    } else {
      _noteForm = {
        "category": [],
        "dateRegistration": "",
        "excluded": false,
        "noteId": "",
        "note": "",
        "shared": [],
        "title": "",
        "userId": "",
      };
    }
  }

  _saveNote(BuildContext context) {
    if ((_noteForm['note'] != "" &&
            _noteForm['note'] != null &&
            noteCurrent != _noteForm['note']) ||
        titleCurrent != _noteForm['title']) {
      setState(() {
        if (currentNote.value.noteId.isNotEmpty) {
          // editar
          _noteForm = {
            "category": _noteForm['category'],
            "dateRegistration": DateTime.now().toString(),
            "excluded": _noteForm['excluded'],
            "noteId": _noteForm['noteId'],
            "note": _noteForm['note'].trim(),
            "shared": _noteForm['shared'],
            "title": _noteForm['title'].trim(),
            "userId": currentUser.value.userId,
          };
        } else {
          // criar
          _noteForm = {
            "category": _noteForm['category'],
            "dateRegistration": DateTime.now().toString(),
            "excluded": false,
            "noteId": _uuid.v4(),
            "note": _noteForm['note'].trim(),
            "shared": _noteForm['shared'],
            "title": _noteForm['title'].trim(),
            "userId": currentUser.value.userId,
          };
        }
      });

      _noteClass.saveNote(context, _noteForm);
      _noteClass.deleteNote();
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - UiSize.appbar * 3;
    final minLines = screenHeight ~/ UiSize.lineHeight;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: SvgButton(
          icon: UniconsLine.arrow_left,
          callback: () => _saveNote(context),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => _saveNote(context),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_noteForm.isNotEmpty)
                  FormInput(
                    initialValue: _noteForm['title'],
                    hintText: TITLE,
                    onSaved: (value) =>
                        setState(() => _noteForm['title'] = value),
                  ),
                if (_noteForm.isNotEmpty)
                  FormInput(
                    initialValue: _noteForm['note'],
                    hintText: NOTE,
                    keyboardType: TextInputType.multiline,
                    minLines: minLines,
                    maxLines: null,
                    onSaved: (value) =>
                        setState(() => _noteForm['note'] = value),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: NoteBottomSheet(
        callback: (value) => setState(() => {}),
        note: _noteForm,
      ),
    );
  }
}
