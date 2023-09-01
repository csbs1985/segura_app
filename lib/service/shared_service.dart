import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:segura_app/firestore/note_firestore.dart';
import 'package:segura_app/service/value_notifier_service.dart';

class SharedService {
  final NoteFirestore _noteFirestore = NoteFirestore();

  Future<List<String>> getAllSharedLists() async {
    List<String> sharedLists = [];

    QuerySnapshot querySnapshot =
        await _noteFirestore.getAllNotes(currentUser.value.userId);

    for (var document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      if (data.containsKey('shared')) {
        for (var element in data['shared']) {
          sharedLists.add(element);
        }
      }
    }

    return sharedLists.toSet().toList();
  }
}
