class CategoryClass {
  List<Map<String, dynamic>> converterQuerySnapshotToList(snapshot) {
    List<Map<String, dynamic>> list = [];

    for (var document in snapshot) {
      Map<String, dynamic> data = document.data();
      data['id'] = document.id;
      list.add(data);
    }

    return list;
  }
}
