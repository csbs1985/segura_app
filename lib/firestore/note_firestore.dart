import 'package:cloud_firestore/cloud_firestore.dart';

class NoteFirestore {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  deleteNote(String noteId) async {
    return await notes.doc(noteId).delete();
  }

  getAllNotes(String userId) {
    return notes
        .where('userId', isEqualTo: userId)
        .where('excluded', isEqualTo: false);
  }

  getAllTrashes(String userId) {
    return notes
        .where('userId', isEqualTo: userId)
        .where('excluded', isEqualTo: true);
  }

  getNoteId(String noteId) async {
    return await notes.doc(noteId).get();
  }

  setCategoryNote(String noteId, List<dynamic> categories) async {
    return await notes.doc(noteId).update({'category': categories});
  }

  setNote(Map<String, dynamic> note) async {
    return await notes.doc(note['noteId']).set(note);
  }

  noteExcludedFalse(String noteId) {
    return notes.doc(noteId).update({'excluded': false});
  }

  noteExcludedTrue(String noteId) {
    return notes.doc(noteId).update({'excluded': true});
  }
}
