import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:senha_app/button/lista_button.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/config/auth_config.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/widget/avatar_widget.dart';

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
        child: SizedBox(
          width: double.infinity,
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
                    const SizedBox(height: 4),
                    TextoText(texto: currentUsuario.value.emailUsuario),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              ListaButton(
                texto: SENHA_CRIAR,
                callback: () => context.pushNamed(RoutesEnum.SENHA.value,
                    pathParameters: {'idSenha': EMPTY}),
              ),
              const SizedBox(height: 4),
              ListaButton(
                texto: SENHA_GERADOR,
                callback: () => context.push(RoutesEnum.GERAR_SENHA.value),
              ),
              const SizedBox(height: 4),
              ListaButton(
                texto: LIXEIRA,
                callback: () => context.push(RoutesEnum.LIXEIRA.value),
              ),
              const SizedBox(height: 4),
              ListaButton(
                texto: BIOMETRIA,
                callback: () => context.push(RoutesEnum.BIOMETRIA.value),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: double.infinity,
        child: ListaButton(
          texto: SAIR,
          callback: () => _authConfig.signOutWithGoogle(),
        ),
      ),
    );
  }
}
