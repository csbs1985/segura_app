import 'package:cloud_firestore/cloud_firestore.dart';

class ReportFirestore {
  CollectionReference reports =
      FirebaseFirestore.instance.collection('reports');

  salvarProblema(Map<String, dynamic> problema) async {
    return await reports.doc(problema['idProblema']).set(problema);
  }
}
