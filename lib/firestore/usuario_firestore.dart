import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senha_app/class/usuario_class.dart';

class UsuarioFirestore {
  CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  getUsuarioEmail(String email) {
    return usuarios.where('email', isEqualTo: email).get();
  }

  getUsuarioId(String idUsuario) async {
    return await usuarios.where('idUsuario', isEqualTo: idUsuario).get();
  }

  pathPerfil(String nomeUsuario, String biografia, String dataAtualizacaoNome) {
    return usuarios.doc(currentUsuario.value.idUsuario).update({
      'biografia': biografia,
      'nomeUsuario': nomeUsuario,
      'dataAtualizacaoNome': dataAtualizacaoNome,
    });
  }

  postUsuario(Map<String, dynamic> _usuario) {
    return usuarios.doc(_usuario['idUsuario']).set(_usuario);
  }

  snapshotsUsuario(String _idUsuario) {
    return usuarios.where('idUsuario', isEqualTo: _idUsuario).snapshots();
  }
}
