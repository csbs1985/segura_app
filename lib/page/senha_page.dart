import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:senha_app/mixin/validator_mixin.dart';
import 'package:senha_app/text/legenda_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/formulario_input.dart';
import 'package:senha_app/modal/gerador_senha_modal.dart';
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
  final SenhaFirestore _senhaFirestore = SenhaFirestore();
  final Uuid uuid = const Uuid();

  final TextEditingController _controllerAnotacao = TextEditingController();
  final TextEditingController _controllerLink = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();

  String _anotacao = "";
  String _dataAlteracao = "";
  String _dataRegistro = "";
  String _idSenha = "";
  String _link = "";
  bool _lixeira = false;
  String _nome = "";
  bool _oculto = false;
  String _senha = "";

  final double _espaco = 24;

  @override
  void initState() {
    super.initState();
    if (widget._idSenha != EMPTY) Future(() => iniciarSenha());
  }

  iniciarSenha() async {
    Map<String, dynamic>? data;

    await _senhaFirestore.getSenhaId(widget._idSenha).then((document) => {
          data = document.data() as Map<String, dynamic>,
          setState(() {
            _controllerAnotacao.text = _anotacao = data!['anotacao'];
            _dataAlteracao = data!['dataAlteracao'];
            _dataRegistro = data!['dataRegistro'];
            _idSenha = data!['idSenha'];
            _controllerLink.text = _link = data!['link'];
            _lixeira = data!['lixeira'];
            _controllerNome.text = _nome = data!['nome'];
            _oculto = data!['oculto'];
            _controllerSenha.text = _senha = data!['senha'];
          }),
        });
  }

  toggleOculto() {
    setState(() => _oculto = !_oculto);
  }

  floatingActionButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? form;
      setState(() {
        if (widget._idSenha != EMPTY) {
          //editar
          form = {
            "anotacao": _controllerAnotacao.text,
            "dataAlteracao": DateTime.now().toString(),
            "dataRegistro": _dataRegistro,
            "idSenha": _idSenha,
            "idUsuario": currentUsuario.value.idUsuario,
            "link": _controllerLink.text,
            "lixeira": _lixeira,
            "nome": _controllerNome.text,
            "oculto": _oculto,
            "senha": _controllerSenha.text,
          };
        } else {
          // criar
          form = {
            "anotacao": _controllerAnotacao.text,
            "dataAlteracao": DateTime.now().toString(),
            "dataRegistro": DateTime.now().toString(),
            "idSenha": uuid.v4(),
            "idUsuario": currentUsuario.value.idUsuario,
            "link": _controllerLink.text,
            "lixeira": false,
            "nome": _controllerNome.text,
            "oculto": _oculto,
            "senha": _controllerSenha.text,
          };
        }
      });

      _senhaClass.postSenha(context, form!);
    }
  }

  abrirGerador(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      builder: (context) => GeradorSenhaModal(
        callback: (value) => {
          Navigator.of(context).pop(),
          setState(() => _controllerSenha.text = _senha = value),
        },
      ),
    );
  }

  @override
  void dispose() {
    _controllerAnotacao.dispose();
    _controllerLink.dispose();
    _controllerNome.dispose();
    _controllerSenha.dispose();
    _controllerUsuario.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconeButton(
          icone: UniconsLine.arrow_left,
          callback: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconeButton(
            icone: UniconsLine.asterisk,
            callback: () => abrirGerador(context),
          ),
          IconeButton(
            icone: _oculto ? UniconsLine.toggle_on : UniconsLine.toggle_off,
            callback: () => toggleOculto(),
          ),
          if (_controllerSenha.text != "")
            IconeButton(
              icone: UniconsLine.trash_alt,
              callback: () =>
                  _senhaClass.toggleSenhaTrue(context, widget._idSenha),
            ),
          const SizedBox(width: 0),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
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
                SizedBox(height: _espaco),
                FormularioInput(
                  controller: _controllerLink,
                  callback: (value) => {},
                  hintText: LINK,
                  validator: (value) => combinarValidacao([
                    () => isIdentificador(value!, _controllerNome.text),
                    () => regexUrl(value),
                  ]),
                ),
                SizedBox(height: _espaco),
                FormularioInput(
                  controller: _controllerUsuario,
                  callback: (value) => {},
                  hintText: USUARIO,
                ),
                SizedBox(height: _espaco),
                FormularioInput(
                  controller: _controllerSenha,
                  callback: (value) => setState(() => _senha = value),
                  hintText: SENHA,
                  validator: (value) => combinarValidacao([
                    () => inNotEmpty(value, SENHA_OBRIGATORIO),
                    () => isSenhaCaracteres(value!),
                  ]),
                ),
                SizedBox(height: _espaco),
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
      ),
      bottomSheet: Container(
        width: MediaQuery.sizeOf(context).width,
        height: _dataAlteracao.isEmpty ? 32 : 48,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            if (_dataAlteracao != "")
              LegendaText(
                texto: _senhaClass.ultimaEdicao(_dataAlteracao),
              ),
            LegendaText(
              texto: _oculto ? SENHA_OCULTA : SENHA_NAO_OCULTA,
            )
          ],
        ),
      ),
      floatingActionButton: _senha == ""
          ? null
          : FloatingActionButton(
              onPressed: () => floatingActionButton(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              child: const Icon(UniconsLine.plus),
            ),
    );
  }
}
