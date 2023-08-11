import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/color_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/form_input.dart';
import 'package:segura_app/widget/note_menu.dart';
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
  final ColorClass _colorClass = ColorClass();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final NoteClass _noteClass = NoteClass();
  final Uuid _uuid = const Uuid();

  int colorCurrent = 0;
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
        "color": currentNote.value.color,
        "dateRegistration": currentNote.value.dateRegistration,
        "excluded": currentNote.value.excluded,
        "noteId": currentNote.value.noteId,
        "note": currentNote.value.note,
        "position": currentNote.value.position,
        "shared": currentNote.value.shared,
        "title": currentNote.value.title,
        "userId": currentNote.value.userId,
      };

      colorCurrent = currentNote.value.color;
      noteCurrent = currentNote.value.note;
      titleCurrent = currentNote.value.title;
    } else {
      _noteForm = {
        "category": [],
        "color": 0,
        "dateRegistration": "",
        "excluded": false,
        "noteId": "",
        "note": "",
        "position": 0,
        "shared": [],
        "title": "",
        "userId": "",
      };
    }
  }

  _formValidad(BuildContext context) {
    if (currentNote.value.noteId.isNotEmpty &&
        colorCurrent != _noteForm['color']) return _editNote(context);
    if (currentNote.value.noteId.isNotEmpty &&
        noteCurrent != _noteForm['note']) {
      return _editNote(context);
    }
    if (currentNote.value.noteId.isNotEmpty &&
        titleCurrent != _noteForm['title']) return _editNote(context);
  }

  _editNote(BuildContext context) {}

  _saveNote(BuildContext context) {
    if ((_noteForm['note'] != "" &&
            _noteForm['note'] != null &&
            noteCurrent != _noteForm['note']) ||
        titleCurrent != _noteForm['title'] ||
        colorCurrent != _noteForm['color']) {
      setState(() {
        if (currentNote.value.noteId.isNotEmpty) {
          // editar
          _noteForm = {
            "category": _noteForm['category'],
            "color": _noteForm['color'],
            "dateRegistration": _noteForm['dateRegistration'],
            "excluded": _noteForm['excluded'],
            "noteId": _noteForm['noteId'],
            "note": _noteForm['note'].trim(),
            "position": _noteForm['position'],
            "shared": _noteForm['shared'],
            "title": _noteForm['title'].trim(),
            "userId": currentUser.value.userId,
          };
        } else {
          // criar
          if (_noteForm['note'] != "" && _noteForm['note'] != null) {
            _noteForm = {
              "category": _noteForm['category'],
              "color": _noteForm['color'],
              "dateRegistration": DateTime.now().toString(),
              "excluded": false,
              "noteId": _uuid.v4(),
              "note": _noteForm['note'].trim(),
              "position": _noteForm['position'],
              "shared": _noteForm['shared'],
              "title": _noteForm['title'].trim(),
              "userId": currentUser.value.userId,
            };
          }
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
      appBar: AppBar(toolbarHeight: 0),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: _colorClass.getBackgroundColor(_noteForm['color']),
          borderRadius: BorderRadius.circular(UiBorder.rounded),
        ),
        child: WillPopScope(
          onWillPop: () => _saveNote(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgButton(
                              icon: UniconsLine.arrow_left,
                              callback: () => _saveNote(context),
                            ),
                          ],
                        ),
                        if (_noteForm.isNotEmpty)
                          FormInput(
                            autoFocus: false,
                            initialValue: _noteForm['title'],
                            hintText: TITLE,
                            onSaved: (value) =>
                                setState(() => _noteForm['title'] = value),
                          ),
                        if (_noteForm.isNotEmpty)
                          FormInput(
                            autoFocus: false,
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
              NoteMenu(
                callback: (value) => setState(() => _noteForm = value),
                note: _noteForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
