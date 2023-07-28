import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/firestore/user_firestore.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/service/auth_service.dart';
import 'package:segura_app/service/local_auth_service.dart';
import 'package:segura_app/service/routes_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthService _authService = AuthService();
  final LocalAuthService _localAuthService = LocalAuthService();
  final UserFirestore _userFirestore = UserFirestore();
  final UserHive _userHive = UserHive();

  @override
  void initState() {
    super.initState();
    checkUserExistence();
  }

  Future<void> checkUserExistence() async {
    final userExists = await _userHive.doesUserExist();

    if (userExists) {
      final Map<dynamic, dynamic>? user = await _userHive.getUser();

      if (user != null) initAuthenticate();
    } else {
      final user = await _authService.signInWithGoogle();
      Map<String, dynamic> userMap = user!.toMap();

      await _userFirestore.saveUser(userMap);
      await _userHive.saveUser(userMap);

      final isLocalAuthRequired = await _localAuthService.isFirstTimeOpening();

      if (isLocalAuthRequired) initAuthenticate();
    }
  }

  initAuthenticate() async {
    final isAuthenticated = await _localAuthService.authenticate();

    if (isAuthenticated) context.push(RouteEnum.HOME.value);
  }

  _logout() async {
    await _authService.signOut();
    context.push(RouteEnum.LOGIN.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          TextButton(
            onPressed: () => initAuthenticate(),
            child: const Text('Usar senha do celular'),
          ),
          TextButton(
            onPressed: () => _logout(),
            child: const Text('Entrar com outra conta'),
          ),
        ],
      ),
    );
  }
}
