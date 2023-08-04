import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/class/toast_class.dart';
import 'package:segura_app/class/validate_class.dart';
import 'package:segura_app/firestore/notes.firestore.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/form_input.dart';
import 'package:segura_app/widget/note_bottom_sheet.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final NoteFirestore _noteFirestore = NoteFirestore();
  final NoteClass _noteClass = NoteClass();
  final ToastClass _toastClass = ToastClass();
  final Uuid _uuid = const Uuid();
  final ValidateClass _validateClass = ValidateClass();

  Map<String, dynamic> _noteForm = {};

  String _noteId = "";

  @override
  void initState() {
    super.initState();
    _fetchNoteData();
  }

  Future<void> _fetchNoteData() async {
    if (currentNoteId.value.isNotEmpty) {
      setState(() => _noteId = currentNoteId.value);
      DocumentSnapshot snapshot = await _noteFirestore.getNoteId(_noteId);

      if (snapshot.exists) {
        setState(() => _noteForm = snapshot.data() as Map<String, dynamic>);
      }
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
    if (_validateClass.isValid(_noteForm['note'])) {
      setState(() {
        if (_noteId.isNotEmpty) {
          // editar
          _noteForm = {
            "category": _noteForm['category'],
            "dateRegistration": DateTime.now().toString(),
            "excluded": _noteForm['excluded'],
            "noteId": _noteForm['noteId'],
            "note": _noteForm['note'],
            "shared": _noteForm['shared'],
            "title": _noteForm['title'],
            "userId": currentUser.value.userId,
          };
        } else {
          // criar
          _noteForm = {
            "category": _noteForm['category'],
            "dateRegistration": DateTime.now().toString(),
            "excluded": false,
            "noteId": _uuid.v4(),
            "note": _noteForm['note'],
            "shared": _noteForm['shared'],
            "title": _noteForm['title'],
            "userId": currentUser.value.userId,
          };
        }
      });

      _noteClass.saveNote(context, _noteForm);
      currentNoteId.value = "";
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
                    onSaved: (value) => _noteForm['title'] = value,
                  ),
                if (_noteForm.isNotEmpty)
                  FormInput(
                    initialValue: _noteForm['note'],
                    hintText: NOTE,
                    keyboardType: TextInputType.multiline,
                    minLines: minLines,
                    maxLines: null,
                    onSaved: (value) => _noteForm['note'] = value,
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
