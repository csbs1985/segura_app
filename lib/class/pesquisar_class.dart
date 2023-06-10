import 'package:algolia/algolia.dart';

class PesquisarClass {
  List<Map<String, dynamic>> converterLista(
    List<AlgoliaObjectSnapshot> snapshot,
  ) {
    List<Map<String, dynamic>> listaConvertida = [];

    for (var item in snapshot) {
      Map<String, dynamic> senha = {
        "anotacao": item.data['anotacao'],
        "dataRegistro": item.data['dataRegistro'],
        "idSenha": item.data['idSenha'],
        "idUsuario": item.data['idUsuario'],
        "link": item.data['link'],
        "lixeira": item.data['lixeira'],
        "nome": item.data['nome'],
        "oculto": item.data['oculto'],
        "senha": item.data['senha'],
        "usuario": item.data['usuario'],
      };

      listaConvertida.add(senha);
    }

    return listaConvertida;
  }
}
