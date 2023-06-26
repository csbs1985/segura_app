import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/appbar/senha_appbar.dart';
import 'package:senha_app/button/floating_button.dart';
import 'package:senha_app/class/senha_class.dart';
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
  final Uuid uuid = const Uuid();

  final TextEditingController _controllerAnotacao = TextEditingController();
  final TextEditingController _controllerLink = TextEditingController();
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerUsuario = TextEditingController();

  String? _senhaAtual;
  final String _dataRegistroAtual = "";
  final List<dynamic> _categorias = [];
  final List<dynamic> _compartilhada = [];
  final List<Map<String, dynamic>> _listaCategorias = [];

  final double _espaco = 24;

  bool _jaPassou = false;

  Map<String, dynamic> senhaForm = {};

  iniciarSenha() async {
    if (!_jaPassou && widget._idSenha != EMPTY) {
      Map<String, dynamic> senhaAtual = {};
      await _senhaFirestore.receberSenhaId(widget._idSenha).then((document) => {
            senhaAtual = document.data() as Map<String, dynamic>,
            senhaForm = {
              "anotacao": senhaAtual['anotacao'],
              "categoria": senhaAtual['categoria'],
              "compartilhada": senhaAtual['compartilhada'],
              "dataRegistro": senhaAtual['dataRegistro'],
              "idSenha": senhaAtual['idSenha'],
              "idUsuario": senhaAtual['idUsuario'],
              "link": senhaAtual['link'],
              "lixeira": senhaAtual['lixeira'],
              "nome": senhaAtual['nome'],
              "senha": senhaAtual['senha'],
              "usuario": senhaAtual['usuario'],
            },
            _definirControllers(),
            _definirCategorias(senhaAtual['categoria']),
          });
    }
  }

  _definirControllers() {
    _controllerAnotacao.text = senhaForm['anotacao'];
    _controllerLink.text = senhaForm['link'];
    _controllerNome.text = senhaForm['nome'];
    _controllerSenha.text = senhaForm['senha'];
    _controllerUsuario.text = senhaForm['usuario'];
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
      setState(() {
        if (widget._idSenha != EMPTY) {
          // editar
          senhaForm = {
            "anotacao": _controllerAnotacao.text,
            "categorias": _categorias,
            "compartilhada": _compartilhada,
            "dataRegistro": _senhaAtual == senhaForm['senha']
                ? _dataRegistroAtual
                : DateTime.now().toString(),
            "idSenha": senhaForm['idSenha'],
            "idUsuario": currentUsuario.value.idUsuario,
            "link": senhaForm['link'],
            "lixeira": senhaForm['lixeira'],
            "nome": senhaForm['nome'],
            "senha": senhaForm['senha'],
            "usuario": _controllerUsuario.text,
          };
        } else {
          // criar
          senhaForm = {
            "anotacao": _controllerAnotacao.text,
            "categorias": _categorias,
            "compartilhada": _compartilhada,
            "dataRegistro": DateTime.now().toString(),
            "idSenha": uuid.v4(),
            "idUsuario": currentUsuario.value.idUsuario,
            "link": _controllerLink.text,
            "lixeira": false,
            "nome": senhaForm['nome'],
            "senha": _controllerSenha.text,
            "usuario": _controllerUsuario.text,
          };
        }
      });

      _senhaClass.salvarSenha(context, senhaForm);
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
    return FutureBuilder(
      future: iniciarSenha(),
      builder: (BuildContext context, _) {
        return Scaffold(
          appBar: SenhaAppbar(
            callback: (value) => setState(() => {
                  _jaPassou = true,
                  senhaForm = value,
                  _controllerSenha.text = senhaForm['senha'],
                }),
            senha: senhaForm,
          ),
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
                              setState(() => senhaForm['nome'] = value),
                          hintText: NOME,
                          validator: (value) => inNotEmpty(value),
                        ),
                        SizedBox(height: _espaco),
                        FormularioInput(
                          controller: _controllerLink,
                          callback: (value) =>
                              setState(() => senhaForm['link'] = value),
                          hintText: LINK,
                          validator: (value) => regexUrl(value!),
                        ),
                        SizedBox(height: _espaco),
                        FormularioInput(
                          controller: _controllerUsuario,
                          callback: (value) =>
                              setState(() => senhaForm['usuario'] = value),
                          hintText: USUARIO,
                        ),
                        SizedBox(height: _espaco),
                        FormularioInput(
                          controller: _controllerSenha,
                          callback: (value) =>
                              setState(() => senhaForm['senha'] = value),
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
                              setState(() => senhaForm['anotacao'] = value),
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 40, 16, 16),
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
          bottomSheet: InicioBottomWidget(item: senhaForm),
          floatingActionButton: FloatingButton(
            callback: () => floatingActionButton(context),
            icone: UniconsLine.check,
          ),
        );
      },
    );
  }
}
