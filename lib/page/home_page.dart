import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticate() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Faça a autenticação para acessar o conteúdo.',
      );
    } catch (e) {
      print("Erro ao autenticar: $e");
    }

    if (isAuthenticated) {
      // O usuário foi autenticado com sucesso.
      print("Autenticação bem-sucedida!");
    } else {
      // Falha na autenticação.
      print("Autenticação falhou!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
