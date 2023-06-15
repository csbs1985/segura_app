import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senha_app/config/value_notifier_config.dart';

class UsuarioFirestore {
  CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  receberUsuarioEmail(String email) {
    return usuarios.where('email', isEqualTo: email).get();
  }

  receberUsuarioId(String idUsuario) async {
    return await usuarios.where('idUsuario', isEqualTo: idUsuario).get();
  }

  editarPerfil(
      String nomeUsuario, String biografia, String dataAtualizacaoNome) {
    return usuarios.doc(currentUsuario.value.idUsuario).update({
      'biografia': biografia,
      'nomeUsuario': nomeUsuario,
      'dataAtualizacaoNome': dataAtualizacaoNome,
    });
  }

  editarToogleBiometria(String usuario, bool biometria) {
    return usuarios.doc(usuario).update({'biometria': biometria});
  }

  salvarUsuario(Map<String, dynamic> _usuario) {
    return usuarios.doc(_usuario['idUsuario']).set(_usuario);
  }
}
