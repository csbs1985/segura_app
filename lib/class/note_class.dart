import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/class/toast_class.dart';
import 'package:segura_app/firestore/notes.firestore.dart';
import 'package:segura_app/service/text_service.dart';

class NoteClass {
  final NoteFirestore _noteFirestore = NoteFirestore();
  final ToastClass _toastClass = ToastClass();

  saveNote(BuildContext context, Map<String, dynamic> note) async {
    try {
      await _noteFirestore.setNote(note);
      context.pop();
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: NOTE_SAVE_ERROR,
      );
    }
  }
}
