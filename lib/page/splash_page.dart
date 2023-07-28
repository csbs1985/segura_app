import 'package:flutter/material.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/service/auth_service.dart';
import 'package:segura_app/service/local_auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthService _authService = AuthService();
  final UserHive _userHive = UserHive();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void initState() {
    super.initState();
    checkUserExistence();
  }

  Future<void> checkUserExistence() async {
    final userExists = await _userHive.doesUserExist();
    if (userExists) {
      final user = await _userHive.getUser();
      if (user != null) {
        final isAuthenticated = await _localAuthService.authenticate();
        if (!isAuthenticated) {
          // Implemente aqui a lógica para lidar com a falta de autenticação local
          // por exemplo, redirecionar o usuário para a página de login.
        }
      }
    } else {
      final user = await _authService.signInWithGoogle();
      if (user == null) {
        // Implemente aqui a lógica para lidar com a falta de autenticação com o Google
      } else {
        Map<String, dynamic> userMap = user.toMap();
        await _userHive.saveUser(userMap);
        final isLocalAuthRequired =
            await _localAuthService.isFirstTimeOpening();
        if (isLocalAuthRequired) {
          final isAuthenticated = await _localAuthService.authenticate();
          if (!isAuthenticated) {
            // Implemente aqui a lógica para lidar com a falta de autenticação local
            // por exemplo, redirecionar o usuário para a página de login.
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha App Flutter'),
      ),
      body: const Center(
        child: Text('Página inicial'),
      ),
    );
  }
}
