import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/button/toggle_button.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/model/usuario_model.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:unicons/unicons.dart';

class DefinirPage extends StatefulWidget {
  const DefinirPage({super.key});

  @override
  State<DefinirPage> createState() => _DefinicoesPageState();
}

class _DefinicoesPageState extends State<DefinirPage> {
  final UsuarioClass _usuarioClass = UsuarioClass();

  bool? isBiometria;

  void _definirBiometria(BuildContext context) {
    setState(() => isBiometria = !isBiometria!);
    _usuarioClass.toogleBiometria(context, isBiometria!);
  }

  @override
  Widget build(BuildContext context) {
    isBiometria = currentUsuario.value.biometria;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconeButton(
          icone: UniconsLine.arrow_left,
          callback: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubtituloText(texto: DEFINIR),
              const SizedBox(height: 24),
              ValueListenableBuilder(
                valueListenable: currentUsuario,
                builder: (BuildContext context, UsuarioModel usuario, _) {
                  return ToggleButton(
                    subtitulo: MODO_ENTRADA,
                    texto: MODO_ENTRADA_DESCRICAO,
                    callback: (value) => _definirBiometria(context),
                    value: isBiometria!,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
