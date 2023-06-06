import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/widget/formulario_input.dart';
import 'package:unicons/unicons.dart';

class SenhaPage extends StatefulWidget {
  const SenhaPage({
    super.key,
    required String idSenha,
  }) : _idSenha = idSenha;

  final String _idSenha;

  @override
  State<SenhaPage> createState() => _SenhaPageState();
}

class _SenhaPageState extends State<SenhaPage> {
  final SenhaClass _senhaClass = SenhaClass();

  TextEditingController _controllerAnotacao = TextEditingController();
  TextEditingController _controllerLink = TextEditingController();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerUsuario = TextEditingController();

  String _anotacao = "";
  String _link = "";
  String _nome = "";
  String _senha = "";
  String _usuario = "";

  @override
  void initState() {
    super.initState();
    Future(() => iniciarSenha());
  }

  iniciarSenha() async {
    final document = await _senhaClass.getSenhaId(widget._idSenha);

    if (document != null) {
      setState(() {
        _controllerAnotacao = _anotacao = document['anotacao'];
        _controllerLink = _link = document['link'];
        _controllerNome = _nome = document['nome'];
        _controllerSenha = _senha = document['senha'];
        _controllerUsuario = _usuario = document['usuario'];
      });
    }
  }

  floatingActionButton() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconeButton(
          icone: UniconsLine.arrow_left,
          callback: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconeButton(
            icone: UniconsLine.trash_alt,
            callback: () => {},
          ),
          const SizedBox(width: 0),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              FormularioInput(
                controller: _controllerNome,
                callback: (value) => {},
                hintText: NOME,
              ),
              FormularioInput(
                controller: _controllerLink,
                callback: (value) => {},
                hintText: LINK,
              ),
              FormularioInput(
                controller: _controllerUsuario,
                callback: (value) => {},
                hintText: USUARIO,
              ),
              FormularioInput(
                controller: _controllerSenha,
                callback: (value) => {},
                hintText: SENHA,
              ),
              FormularioInput(
                controller: _controllerAnotacao,
                callback: (value) => {},
                hintText: ANOTACAO,
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => floatingActionButton(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UiBorda.arredondada)),
        child: const Icon(UniconsLine.plus),
      ),
    );
  }
}
