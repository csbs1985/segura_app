import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:senha_app/button/lista_button.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/config/auth_config.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/avatar_widget.dart';
import 'package:unicons/unicons.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final AuthConfig _authConfig = AuthConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AvatarWidget(size: 48),
                  const SizedBox(height: 24),
                  SubtituloText(texto: currentUsuario.value.nomeUsuario),
                  const SizedBox(height: UiTamanho.espacoLista),
                  TextoText(texto: currentUsuario.value.emailUsuario),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            ListaButton(
              texto: SENHA_CRIAR,
              icone: UniconsLine.shield_check,
              callback: () => context.pushNamed(RoutesEnum.SENHA.value,
                  pathParameters: {'idSenha': EMPTY}),
            ),
            const SizedBox(height: UiTamanho.espacoLista),
            ListaButton(
              texto: SENHA_GERADOR,
              icone: UniconsLine.asterisk,
              callback: () => context.push(RoutesEnum.GERAR_SENHA.value),
            ),
            const SizedBox(height: UiTamanho.espacoLista),
            ListaButton(
              texto: LIXEIRA,
              icone: UniconsLine.trash_alt,
              callback: () => context.push(RoutesEnum.LIXEIRA.value),
            ),
            const SizedBox(height: UiTamanho.espacoLista),
            ListaButton(
              texto: MODO_ENTRADA,
              icone: Icons.fingerprint,
              callback: () => context.push(RoutesEnum.MODO_ENTRADA.value),
            ),
            ListaButton(
              texto: DOAR,
              icone: UniconsLine.heart,
              callback: () => context.push(RoutesEnum.DOAR.value),
            ),
            ListaButton(
              texto: RELATAR_PROBLEMA,
              icone: UniconsLine.exclamation_triangle,
              callback: () => context.push(RoutesEnum.RELATAR_PROBLEMA.value),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: double.infinity,
        child: ListaButton(
          texto: SAIR,
          icone: UniconsLine.sign_in_alt,
          callback: () => _authConfig.signOutWithGoogle(),
        ),
      ),
    );
  }
}
