import 'package:local_auth/local_auth.dart';
import 'package:senha_app/config/constante_config.dart';

class LocalAuthClass {
  final LocalAuthentication auth;

  LocalAuthClass({required this.auth});

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: AUTENTICAR_DESBLOQUEAR,
    );
  }
}
