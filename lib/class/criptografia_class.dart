import 'package:encrypt/encrypt.dart';
import 'package:senha_app/class/usuario_class.dart';

class CriptografiaClass {
  final key = Key.fromUtf8(currentUsuario.value.idUsuario);
  final iv = IV.fromLength(16);

  String criptografar(String texto) {
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(texto, iv: iv);
    return encrypted.base64;
  }

  String descriptografar(String textoCriptografado) {
    final encrypter = Encrypter(AES(key));
    final encrypted = Encrypted.fromBase64(textoCriptografado);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
