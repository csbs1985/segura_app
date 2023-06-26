import 'package:flutter/material.dart';
import 'package:senha_app/appbar/voltar_appbar.dart';
import 'package:senha_app/button/segundo_button.dart';
import 'package:senha_app/class/copiar_class.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/component/gerar_senha_component.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/mixin/validator_mixin.dart';
import 'package:unicons/unicons.dart';

class GerarSenhaPage extends StatefulWidget {
  const GerarSenhaPage({super.key});

  @override
  State<GerarSenhaPage> createState() => _GerarSenhaPageState();
}

class _GerarSenhaPageState extends State<GerarSenhaPage> with ValidatorMixin {
  final CopiarClass _copiarClass = CopiarClass();

  String _senhaGerada = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: GerarSenhaComponent(
        tipo: GerarSenhaTipoEnum.PAGE,
        callback: (value) => setState(() => _senhaGerada = value),
      ),
      floatingActionButton: _senhaGerada.isEmpty
          ? null
          : SegundoButton(
              callback: () => _copiarClass.copiar(
                context: context,
                texto: _senhaGerada,
                mensagem: SENHA_COPIADA,
              ),
              icone: UniconsLine.copy,
            ),
    );
  }
}
