import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/widget/note_trash_bottom_sheet.dart';
import 'package:unicons/unicons.dart';

class NoteTrashPage extends StatefulWidget {
  const NoteTrashPage({super.key});

  @override
  State<NoteTrashPage> createState() => _NoteTrashPageState();
}

class _NoteTrashPageState extends State<NoteTrashPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final NoteClass _noteClass = NoteClass();

  Map<String, dynamic> _noteForm = {};

  @override
  void initState() {
    super.initState();
    _fetchNoteData();
  }

  Future<void> _fetchNoteData() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: SvgButton(
          icon: UniconsLine.arrow_left,
          callback: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Text(
                  _noteForm['title'] != "" ? _noteForm['title'] : TITLE,
                  style: _noteForm['title'] != ""
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Text(
                  _noteForm['note'] != "" ? _noteForm['note'] : NOTE,
                  style: _noteForm['note'] != ""
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: NoteTrashBottomSheet(
        callback: (value) => setState(() => {}),
        note: _noteForm,
      ),
    );
  }
}
