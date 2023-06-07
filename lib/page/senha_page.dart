import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/mixin/validator_mixin.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/widget/formulario_input.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

class SenhaPage extends StatefulWidget {
  const SenhaPage({
    super.key,
    required String idSenha,
  }) : _idSenha = idSenha;

  final String _idSenha;

  @override
  State<SenhaPage> createState() => _SenhaPageState();
}

class _SenhaPageState extends State<SenhaPage> with ValidatorMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SenhaClass _senhaClass = SenhaClass();
  final Uuid uuid = const Uuid();

  final TextEditingController _controllerAnotacao = TextEditingController();
  final TextEditingController _controllerLink = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();

  final String _anotacao = "";
  final String _link = "";
  final String _nome = "";
  final String _senha = "";
  final String _usuario = "";

  final bool _toggleOculto = false;

  @override
  void initState() {
    super.initState();
    // Future(() => iniciarSenha());
  }

  // iniciarSenha() async {
  //   final QuerySnapshot<Map<String, dynamic>> document =
  //       await _senhaClass.getSenhaId(widget._idSenha);

  //   if (document != null) {
  //     setState(() {
  //       _controllerAnotacao = _anotacao = document['anotacao'];
  //       _controllerLink = _link = document['link'];
  //       _controllerNome = _nome = document['nome'];
  //       _controllerSenha = _senha = document['senha'];
  //       _controllerUsuario = _usuario = document['usuario'];
  //     });
  //   }
  // }

  floatingActionButton() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> form = {
        "anotacao": _controllerAnotacao.text,
        "dataAlteracao": "",
        "dataRegistro": DateTime.now().toString(),
        "idSenha": uuid.v4(),
        "idUsuario": currentUsuario.value.idUsuario,
        "link": _controllerLink.text,
        "nome": _controllerNome.text,
        "oculto": _toggleOculto,
        "senha": _controllerSenha.text,
      };

      _senhaClass.postSenha(form);
    }
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
          key: _formKey,
          child: Column(
            children: [
              FormularioInput(
                controller: _controllerNome,
                callback: (value) => {},
                hintText: NOME,
                validator: (value) =>
                    isIdentificador(_controllerLink.text, value!),
              ),
              FormularioInput(
                controller: _controllerLink,
                callback: (value) => {},
                hintText: LINK,
                validator: (value) => combinarValidacao([
                  () => isIdentificador(value!, _controllerNome.text),
                  () => regexUrl(value),
                ]),
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
                validator: (value) => combinarValidacao([
                  () => inNotEmpty(value, SENHA_OBRIGATORIO),
                  () => isSenhaCaracteres(value!),
                ]),
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
