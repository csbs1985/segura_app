import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/class/toast_class.dart';
import 'package:segura_app/firestore/note_firestore.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_duration.dart';

class NoteClass {
  final NoteFirestore _noteFirestore = NoteFirestore();
  final ToastClass _toastClass = ToastClass();

  selectNote(Map<String, dynamic> note) {
    currentNote.value = NoteModel(
      category: note['category'].cast<String>(),
      color: note['color'],
      dateRegistration: note['dateRegistration'],
      excluded: note['excluded'],
      note: note['note'],
      noteId: note['noteId'] ?? note['objectID'],
      position: note['position'],
      shared: note['shared'].cast<String>(),
      title: note['title'],
      userId: note['userId'],
    );
  }

  deleteNote() {
    currentNote.value = NoteModel(
      category: [],
      color: 0,
      dateRegistration: "",
      excluded: false,
      note: "",
      noteId: "",
      position: 0,
      shared: [],
      title: "",
      userId: "",
    );
  }

  saveCategoryNote(
      BuildContext context, String noteId, List<dynamic> listCategories) async {
    try {
      await _noteFirestore.setCategoryNote(noteId, listCategories);
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: NOTE_SAVE_ERROR,
      );
    }
  }

  saveNote(BuildContext context, Map<String, dynamic> note) async {
    try {
      await _noteFirestore.setNote(note);
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: NOTE_SAVE_ERROR,
      );
    }
  }

  void noteExcludedTrue(BuildContext context, String noteId) async {
    try {
      await _noteFirestore.noteExcludedTrue(noteId);

      _toastClass.sucesso(
        context: context,
        text: NOTE_DELETAR_SUCCESS,
      );

      Future.delayed(const Duration(milliseconds: UiDuration.toast), () {
        context.pop();
      });
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: NOTE_DELETAR_ERROR,
      );
    }
  }

  void noteExcludedFalse(BuildContext context, String noteId) async {
    try {
      await _noteFirestore.noteExcludedFalse(noteId);
      context.pop();
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: RESTORE_ERROR,
      );
    }
  }

  void deleteNoteCloud(BuildContext context, String noteId) async {
    try {
      await _noteFirestore.deleteNote(noteId);
      context.pop();
    } catch (e) {
      _toastClass.erro(
        context: context,
        text: NOTE_DELETAR_ERROR,
      );
    }
  }
}

enum NoteTypeEnum {
  NEW('new'),
  TRASH('trash'),
  NOTE('note');

  final String value;
  const NoteTypeEnum(this.value);
}
