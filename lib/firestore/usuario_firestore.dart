import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senha_app/config/value_notifier_config.dart';

class UsuarioFirestore {
  CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  getUsuarioEmail(String email) {
    return usuarios.where('email', isEqualTo: email).get();
  }

  getUsuarioId(String idUsuario) async {
    return await usuarios.where('idUsuario', isEqualTo: idUsuario).get();
  }

  getUsuarioDoc(String docUsuario) async {
    return await usuarios.doc('docUsuario').get();
  }

  pathPerfil(String nomeUsuario, String biografia, String dataAtualizacaoNome) {
    return usuarios.doc(currentUsuario.value.idUsuario).update({
      'biografia': biografia,
      'nomeUsuario': nomeUsuario,
      'dataAtualizacaoNome': dataAtualizacaoNome,
    });
  }

  pathToogleBiometria(String usuario, bool biometria) {
    return usuarios.doc(usuario).update({'biometria': biometria});
  }

  postUsuario(Map<String, dynamic> _usuario) {
    return usuarios.doc(_usuario['idUsuario']).set(_usuario);
  }

  snapshotsUsuario(String _idUsuario) {
    return usuarios.where('idUsuario', isEqualTo: _idUsuario).snapshots();
  }
}
