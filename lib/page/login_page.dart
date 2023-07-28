import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/model/user_model.dart';
import 'package:segura_app/service/auth_service.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/theme/ui_icon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();

  Future<void> _signInWithGoogle(BuildContext context) async {
    final UserModel? user = await _authService.signInWithGoogle();

    if (user != null) context.push(RouteEnum.HOME.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                UiIcon.logo,
                height: MediaQuery.sizeOf(context).width / 3,
              ),
            ),
            Center(
              child: Text(
                ENTRAR_BEM_VINDO,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Center(
              child: Text(
                ENTRAR_GOOGLE,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),
            IconButton(
              onPressed: () => _signInWithGoogle(context),
              icon: SvgPicture.asset(UiIcon.google),
            )
          ],
        ),
      ),
    );
  }
}
