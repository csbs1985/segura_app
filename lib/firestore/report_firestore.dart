import 'package:cloud_firestore/cloud_firestore.dart';

class ReportFirestore {
  CollectionReference reports =
      FirebaseFirestore.instance.collection('reports');

  salvarProblema(Map<String, dynamic> problem) async {
    return await reports.doc(problem['reportId']).set(problem);
  }
}
