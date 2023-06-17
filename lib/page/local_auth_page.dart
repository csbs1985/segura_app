import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:senha_app/button/3d_button.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/local_auth_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_icone.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/loading_widget.dart';

class LocalAuthPage extends StatefulWidget {
  const LocalAuthPage({super.key});

  @override
  State<LocalAuthPage> createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  _checkLocalAuth() async {
    final auth = context.read<LocalAuthClass>();
    final isLocalAuthAvailable = await auth.isBiometricAvailable();
    currentIsLocalAuthFailed.value = false;

    if (isLocalAuthAvailable) {
      final authenticated = await auth.authenticate();

      if (!authenticated) {
        currentIsLocalAuthFailed.value = true;
      } else {
        if (!mounted) return;
        context.push(RoutesEnum.INICIO.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _checkLocalAuth(),
      builder: (BuildContext context, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: ValueListenableBuilder(
            valueListenable: currentTema,
            builder: (BuildContext context, Brightness tema, _) {
              bool isEscuro = tema == Brightness.dark ? true : false;

              return Container(
                width: MediaQuery.sizeOf(context).width,
                color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
                child: ValueListenableBuilder<bool>(
                  valueListenable: currentIsLocalAuthFailed,
                  builder: (BuildContext context, bool isLocalAuthFailed, _) {
                    if (isLocalAuthFailed)
                      return Column(
                        children: [
                          Expanded(
                            child: SvgPicture.asset(
                              UiIcone.segura,
                              height: UiTamanho.logo,
                            ),
                          ),
                          Button3dButton(
                            callback: (value) => _checkLocalAuth(),
                            texto: AUTENTICAR_NOVAMENTE,
                          ),
                          const SizedBox(height: 24),
                        ],
                      );

                    return const LoadingWidget();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
