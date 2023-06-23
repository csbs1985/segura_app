import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/appbar/senha_appbar.dart';
import 'package:senha_app/button/floating_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/firestore/categoria_firestore.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:senha_app/mixin/validator_mixin.dart';
import 'package:senha_app/modal/categoria_modal.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/inicio_bottom_widget.dart';
import 'package:senha_app/widget/formulario_input.dart';
import 'package:senha_app/widget/lista_categoria_senha_widget.dart';
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
  final CategoriaFirestore _categoriaFirestore = CategoriaFirestore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SenhaClass _senhaClass = SenhaClass();
  final SenhaFirestore _senhaFirestore = SenhaFirestore();
  final ToastClass _toastClass = ToastClass();
  final Uuid uuid = const Uuid();

  final TextEditingController _controllerAnotacao = TextEditingController();
  final TextEditingController _controllerLink = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();

  String _anotacao = "";
  String _dataRegistro = "";
  String _idSenha = "";
  String _link = "";
  bool _lixeira = false;
  String _nome = "";
  bool _oculto = false;
  String _senha = "";
  String _usuario = "";
  String _usuarioAtual = "";
  String _dataRegistroAtual = "";
  final List<dynamic> _categorias = [];
  final List<Map<String, dynamic>> _listaCategorias = [];

  final double _espaco = 24;
  Map<String, dynamic> selecionada = {};

  @override
  void initState() {
    super.initState();

    if (widget._idSenha != EMPTY) Future(() => iniciarSenha());
  }

  iniciarSenha() async {
    await _senhaFirestore.receberSenhaId(widget._idSenha).then((document) => {
          selecionada = document.data() as Map<String, dynamic>,
          setState(() {
            _controllerAnotacao.text = _anotacao = selecionada['anotacao'];
            _dataRegistro = _dataRegistroAtual = selecionada['dataRegistro'];
            _idSenha = selecionada['idSenha'];
            _controllerLink.text = _link = selecionada['link'];
            _lixeira = selecionada['lixeira'];
            _controllerNome.text = _nome = selecionada['nome'];
            _oculto = selecionada['oculto'];
            _controllerSenha.text =
                _senha = _usuarioAtual = selecionada['senha'];
            _controllerUsuario.text = _usuario = selecionada['usuario'];
          }),
          _definirCategorias(selecionada['categoria']),
        });
  }

  _definirCategorias(List<dynamic> categorias) {
    Map<String, dynamic>? categoria;

    for (var item in categorias) {
      _categoriaFirestore.receberCategoriaId(item).then((result) => {
            categoria = result.data() as Map<String, dynamic>,
            setState(() => _listaCategorias.add(categoria!)),
          });
    }

    currentCategorias.value = _listaCategorias;
  }

  void _abrirCategoriaModal() {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const CategoriaModal(),
    );
  }

  toggleOculto() {
    setState(() => _oculto = !_oculto);

    _toastClass.sucesso(
      context: context,
      texto: _oculto ? SENHA_OCULTA : SENHA_NAO_OCULTA,
    );
  }

  floatingActionButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? form;
      setState(() {
        if (widget._idSenha != EMPTY) {
          //editar
          form = {
            "anotacao": _controllerAnotacao.text,
            "categorias": _categorias,
            "dataRegistro": _usuarioAtual == _senha
                ? _dataRegistroAtual
                : DateTime.now().toString(),
            "idSenha": _idSenha,
            "idUsuario": currentUsuario.value.idUsuario,
            "link": _controllerLink.text,
            "lixeira": _lixeira,
            "nome": _nome,
            "oculto": _oculto,
            "senha": _senha,
            "usuario": _controllerUsuario.text,
          };
        } else {
          // criar
          form = {
            "anotacao": _controllerAnotacao.text,
            "categorias": _categorias,
            "dataRegistro": DateTime.now().toString(),
            "idSenha": uuid.v4(),
            "idUsuario": currentUsuario.value.idUsuario,
            "link": _controllerLink.text,
            "lixeira": false,
            "nome": _nome,
            "oculto": _oculto,
            "senha": _controllerSenha.text,
            "usuario": _controllerUsuario.text,
          };
        }
      });

      _senhaClass.salvarSenha(context, form!);
    }
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
      appBar: const SenhaAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormularioInput(
                  controller: _controllerNome,
                  callback: (value) => setState(() => _nome = value),
                  hintText: NOME,
                  validator: (value) => inNotEmpty(value),
                ),
                SizedBox(height: _espaco),
                FormularioInput(
                  controller: _controllerLink,
                  callback: (value) => setState(() => _link = value),
                  hintText: LINK,
                  validator: (value) => regexUrl(value!),
                ),
                SizedBox(height: _espaco),
                FormularioInput(
                  controller: _controllerUsuario,
                  callback: (value) => setState(() => _usuario = value),
                  hintText: USUARIO,
                ),
                SizedBox(height: _espaco),
                FormularioInput(
                  controller: _controllerSenha,
                  callback: (value) => setState(() => _senha = value),
                  hintText: SENHA,
                  validator: (value) => combinarValidacao([
                    () => inNotEmpty(value),
                    () => isSenhaCaracteres(value!),
                  ]),
                ),
                SizedBox(height: _espaco),
                FormularioInput(
                  controller: _controllerAnotacao,
                  callback: (value) => setState(() => _anotacao = value),
                  hintText: ANOTACAO,
                  minLines: 1,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
                if (_listaCategorias.isNotEmpty)
                  ValueListenableBuilder(
                    valueListenable: currentCategorias,
                    builder: (BuildContext context,
                        List<Map<String, dynamic>> categorias, _) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                        child: ListaCategoriaSenhaWidget(
                          listaCategorias: categorias,
                          callback: () => _abrirCategoriaModal(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: InicioBottomWidget(senha: selecionada),
      floatingActionButton: FloatingButton(
        callback: () => floatingActionButton(context),
        icone: UniconsLine.check,
      ),
    );
  }
}
