class TextoClass {
  List<String> ordenarCrescente(List<dynamic> lista) {
    List<String> sortedList =
        lista.whereType<String>().map((element) => element).toList();

    sortedList.sort();
    return sortedList;
  }

  bool validarVariavel(dynamic value) {
    if (value == null) return false;
    if (value == "") return false;
    if (value.isEmpty) return false;
    return true;
  }
}
