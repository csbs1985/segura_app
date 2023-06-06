import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:senha_app/config/auth_config.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/mensagem_text.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/theme/ui_svg.dart';

class EntrarPage extends StatefulWidget {
  const EntrarPage({super.key});

  @override
  State<EntrarPage> createState() => _EntrarPageState();
}

class _EntrarPageState extends State<EntrarPage> {
  final AuthConfig _authConfig = AuthConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Expanded(child: SvgPicture.asset(UiSvg.logo)),
            const Center(
              child: SubtituloText(texto: ENTRAR_BEM_VINDO),
            ),
            const Center(
              child: MensagemText(texto: ENTRAR_GOOGLE),
            ),
            const SizedBox(height: 48),
            IconButton(
              onPressed: () => _authConfig.singInWithGoogle(),
              icon: SvgPicture.asset(UiSvg.google),
            )
          ],
        ),
      ),
    );
  }
}
