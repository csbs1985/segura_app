import 'package:cloud_firestore/cloud_firestore.dart';

class NoteFirestore {
  CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  getAllNotes(String userId) {
    return notes
        .orderBy('title')
        .orderBy('note')
        .where('userId', isEqualTo: userId)
        .where('excluded', isEqualTo: false);
  }

  getNoteId(String noteId) async {
    return await notes.doc(noteId).get();
  }

  setNote(Map<String, dynamic> note) async {
    return await notes.doc(note['noteId']).set(note);
  }

  noteExcludedTrue(String noteId) {
    return notes.doc(noteId).update({'excluded': true});
  }
}
