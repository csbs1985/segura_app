import 'package:flutter/material.dart';
import 'package:senha_app/appbar/modal_appbar.dart';
import 'package:senha_app/button/segundo_button.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/component/gerar_senha_component.dart';
import 'package:senha_app/mixin/validator_mixin.dart';
import 'package:unicons/unicons.dart';

class GerarSenhaModal extends StatefulWidget {
  const GerarSenhaModal({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<GerarSenhaModal> createState() => _GerarSenhaModalState();
}

class _GerarSenhaModalState extends State<GerarSenhaModal> with ValidatorMixin {
  String _senhaGerada = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModalAppbar(),
      body: GerarSenhaComponent(
        tipo: GerarSenhaTipoEnum.MODAL,
        callback: (value) => setState(() => _senhaGerada = value),
      ),
      floatingActionButton: _senhaGerada == ""
          ? null
          : SegundoButton(
              callback: () => widget._callback(_senhaGerada),
              icone: UniconsLine.check,
            ),
    );
  }
}
