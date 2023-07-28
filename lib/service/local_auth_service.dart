import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isFirstTimeOpening() async {
    final bool canAuthenticateWithBiometrics =
        await _localAuth.canCheckBiometrics;
    return canAuthenticateWithBiometrics ||
        await _localAuth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    final isBiometricAvailable = await _localAuth.canCheckBiometrics;
    if (!isBiometricAvailable) return false;

    final isBiometricAuthorized = await _localAuth.authenticate(
      localizedReason: 'Por favor, autentique-se para acessar.',
    );

    return isBiometricAuthorized;
  }
}
