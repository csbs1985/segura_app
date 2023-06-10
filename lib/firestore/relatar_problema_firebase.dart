import 'package:cloud_firestore/cloud_firestore.dart';

class RelatarProblemaFirestore {
  CollectionReference problemas =
      FirebaseFirestore.instance.collection('problemas');

  postProblema(Map<String, dynamic> problema) async {
    return await problemas.doc(problema['idProblema']).set(problema);
  }
}
