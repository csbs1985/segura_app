import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isFirstTimeOpening() async {
    final bool canAuthenticateWithBiometrics =
        await _localAuth.canCheckBiometrics;
    return canAuthenticateWithBiometrics ||
        await _localAuth.isDeviceSupported();
  }

  Future<String?> authenticate(BuildContext context) async {
    final isBiometricAvailable = await _localAuth.canCheckBiometrics;
    if (!isBiometricAvailable) return null;

    final isBiometricAuthorized = await _localAuth.authenticate(
      localizedReason: 'Desbloqueie seu celular',
      options: const AuthenticationOptions(
        stickyAuth: true,
      ),
      authMessages: <AuthMessages>[
        const AndroidAuthMessages(
          signInTitle: 'Segura',
          cancelButton: 'Não, obrigado',
        ),
        const IOSAuthMessages(
          cancelButton: 'Não, obrigado',
        ),
      ],
    );

    if (isBiometricAuthorized) {
      return ModalRoute.of(context)?.settings.name;
    } else {
      return null;
    }
  }
}
