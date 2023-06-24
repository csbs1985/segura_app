import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/appbar/senha_appbar.dart';
import 'package:senha_app/button/floating_button.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/texto_class.dart';
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
  final TextoClass _textoClass = TextoClass();
  final Uuid uuid = const Uuid();

  final TextEditingController _controllerAnotacao = TextEditingController();
  final TextEditingController _controllerLink = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();

  final String _senhaAtual = "";
  final String _dataRegistroAtual = "";
  final List<dynamic> _categorias = [];
  final List<Map<String, dynamic>> _listaCategorias = [];

  final double _espaco = 24;
  Map<String, dynamic> selecionada = {};

  Map<String, dynamic> senhaForm = {};

  @override
  void initState() {
    super.initState();

    if (widget._idSenha != EMPTY) Future(() => iniciarSenha());
  }

  iniciarSenha() async {
    await _senhaFirestore.receberSenhaId(widget._idSenha).then((document) => {
          selecionada = document.data() as Map<String, dynamic>,
          senhaForm = {
            "anotacao": selecionada['anotacao'],
            "categoria": selecionada['categoria'],
            "compartilhada": selecionada['compartilhada'],
            "dataRegistro": selecionada['dataRegistro'],
            "idSenha": selecionada['idSenha'],
            "idUsuario": selecionada['idUsuario'],
            "link": selecionada['link'],
            "nome": selecionada['nome'],
            "senha": selecionada['senha'],
            "usuario": selecionada['usuario'],
          },
          currentForm.value = senhaForm,
          _definirControllers(),
          _definirCategorias(selecionada['categoria']),
        });
  }

  _definirControllers() {
    _controllerSenha.text = currentForm.value['senha'];
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

  floatingActionButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic>? form;
      setState(() {
        if (widget._idSenha != EMPTY) {
          //editar
          form = {
            "anotacao": _controllerAnotacao.text,
            "categorias": _categorias,
            "dataRegistro": _senhaAtual == currentForm.value['senha']
                ? _dataRegistroAtual
                : DateTime.now().toString(),
            "idSenha": currentForm.value['idSenha'],
            "idUsuario": currentUsuario.value.idUsuario,
            "link": _controllerLink.text,
            "lixeira": currentForm.value['lixeira'],
            "nome": currentForm.value['nome'],
            "senha": currentForm.value['senha'],
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
            "nome": currentForm.value['nome'],
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
    currentForm.value = {};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SenhaAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ValueListenableBuilder(
            valueListenable: currentForm,
            builder: (BuildContext context, Map<String, dynamic> senha, _) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormularioInput(
                      controller: _controllerNome,
                      callback: (value) =>
                          setState(() => senha['nome'] = value),
                      hintText: NOME,
                      validator: (value) => inNotEmpty(value),
                    ),
                    SizedBox(height: _espaco),
                    FormularioInput(
                      controller: _controllerLink,
                      callback: (value) =>
                          setState(() => senha['link'] = value),
                      hintText: LINK,
                      validator: (value) => regexUrl(value!),
                    ),
                    SizedBox(height: _espaco),
                    FormularioInput(
                      controller: _controllerUsuario,
                      callback: (value) =>
                          setState(() => senha['usuario'] = value),
                      hintText: USUARIO,
                    ),
                    SizedBox(height: _espaco),
                    FormularioInput(
                      controller: _controllerSenha,
                      callback: (value) =>
                          setState(() => senha['senha'] = value),
                      hintText: SENHA,
                      validator: (value) => combinarValidacao([
                        () => inNotEmpty(value),
                        () => isSenhaCaracteres(value!),
                      ]),
                    ),
                    SizedBox(height: _espaco),
                    FormularioInput(
                      controller: _controllerAnotacao,
                      callback: (value) =>
                          setState(() => senha['anotacao'] = value),
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
              );
            },
          ),
        ),
      ),
      bottomSheet:
          _textoClass.validarVariavel(currentForm.value['dataRegistro'])
              ? InicioBottomWidget()
              : Container(),
      floatingActionButton: FloatingButton(
        callback: () => floatingActionButton(context),
        icone: UniconsLine.check,
      ),
    );
  }
}
