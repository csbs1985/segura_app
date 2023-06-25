import 'package:flutter/material.dart';
import 'package:senha_app/button/primeiro_button.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/mixin/validator_mixin.dart';
import 'package:senha_app/text/error_text.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/text/titulo_text.dart';
import 'package:senha_app/widget/padrao_input.dart';
import 'package:senha_app/widget/padrao_selecionar_widget.dart';

class GerarSenhaComponent extends StatefulWidget {
  const GerarSenhaComponent({
    super.key,
    required Function callback,
    required GerarSenhaTipoEnum tipo,
  })  : _callback = callback,
        _tipo = tipo;

  final Function _callback;
  final GerarSenhaTipoEnum _tipo;

  @override
  State<GerarSenhaComponent> createState() => _GerarSenhaModalState();
}

class _GerarSenhaModalState extends State<GerarSenhaComponent>
    with ValidatorMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SenhaClass _senhaClass = SenhaClass();
  final TextEditingController _controllerTamanho = TextEditingController();

  String _senhaGerada = "";
  String tamanho = "8";
  bool isSelecionado = true;
  List<String> listaSelecionado = [GerarSenhaEnum.MINUSCULA.name];

  final double _height = 16;

  @override
  void initState() {
    super.initState();
    _controllerTamanho.text = tamanho;
  }

  void _gerarSenha() {
    if (_formKey.currentState!.validate()) {
      if (isSelecionado) {
        setState(() => _senhaGerada =
            _senhaClass.gerarSenha(listaSelecionado, int.parse(tamanho)));
        FocusScope.of(context).unfocus();
      } else
        setState(() => _senhaGerada = "");

      widget._callback(_senhaGerada);
    }
  }

  void _verificaSelecionados(List<String> value) {
    setState(() {
      listaSelecionado = value;
      isSelecionado = listaSelecionado.isEmpty ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SubtituloText(texto: SENHA_GERAR),
                SizedBox(height: _height),
                const TextoText(texto: SENHA_GERAR_DESCRICAO),
                SizedBox(height: _height),
                const TextoText(texto: SENHA_CARACTERES),
                SizedBox(height: _height),
                PadraoSelecionarWidget(
                  callback: (value) => _verificaSelecionados(value),
                ),
                if (!isSelecionado)
                  const ErroText(texto: SENHA_CARACTERES_ERRO),
                SizedBox(height: _height),
                const TextoText(texto: SENHA_TAMANHO),
                SizedBox(height: _height),
                PadraoInput(
                  controller: _controllerTamanho,
                  keyboardType: TextInputType.number,
                  callback: (value) => setState(() => tamanho = value),
                  validator: (value) => isSenhaCaracteresInt(value!),
                ),
                SizedBox(height: _height),
                PrimeirolButton(
                  callback: (value) => _gerarSenha(),
                  texto: SENHA_GERAR,
                ),
                if (_senhaGerada.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        TituloText(texto: _senhaGerada),
                        const TextoText(texto: SENHA_GERADA),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
