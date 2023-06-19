class TextoClass {
  List<String> ordenarCrescente(List<dynamic> lista) {
    List<String> sortedList =
        lista.whereType<String>().map((element) => element).toList();

    sortedList.sort();
    return sortedList;
  }
}
