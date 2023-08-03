import 'package:algolia/algolia.dart';

class SearchClass {
  List<Map<String, dynamic>> convertListToMaps(
      List<AlgoliaObjectSnapshot> snapshots) {
    List<Map<String, dynamic>> listOfMaps = [];

    for (AlgoliaObjectSnapshot snapshot in snapshots) {
      Map<String, dynamic> mapFromSnapshot = snapshot.data;
      listOfMaps.add(mapFromSnapshot);
    }

    return listOfMaps;
  }
}
