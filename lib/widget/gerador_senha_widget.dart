import 'package:flutter/material.dart';
import 'package:senha_app/button/3d_button.dart';
import 'package:senha_app/class/gerador_senha_class.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/mixin/validator_mixin.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/text/titulo_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/widget/padrao_input.dart';
import 'package:senha_app/widget/seleciona_widget.dart';
import 'package:unicons/unicons.dart';

class GeradorSenhaWidget extends StatefulWidget {
  const GeradorSenhaWidget({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<GeradorSenhaWidget> createState() => _GeradorSenhaWidgetState();
}

class _GeradorSenhaWidgetState extends State<GeradorSenhaWidget>
    with ValidatorMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SenhaClass _senhaClass = SenhaClass();
  final ToastClass _toastClass = ToastClass();

  String senhaGerada = "";
  int tamanho = 8;

  final double _height = 16;

  geradorSenhaCallback(List<GerarSenhaModel> value) {}

  _gerarSenha() {
    if (_formKey.currentState!.validate()) {
      bool isSelecionado =
          listaGeradorSenha.any((registro) => registro.selecionado == true);

      if (isSelecionado) {
        setState(() =>
            senhaGerada = _senhaClass.gerarSenha(listaGeradorSenha, tamanho));
      } else {
        setState(() => senhaGerada = "");
        _toastClass.abrirToast(
          context: context,
          estilo: SenhaEnum.ERRO.value,
          texto: SENHA_GERADOR_ERRO,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SubtituloText(texto: SENHA_GERADOR),
                SizedBox(height: _height),
                const TextoText(texto: SENHA_GERADOR_DESCRICAO),
                SizedBox(height: _height),
                const TextoText(texto: SENHA_CARACTERES),
                SizedBox(height: _height),
                SelecionarWidget(
                  callback: (value) => geradorSenhaCallback(value),
                  lista: listaGeradorSenha,
                ),
                SizedBox(height: _height),
                const TextoText(texto: SENHA_TAMANHO),
                SizedBox(height: _height),
                PadraoInput(
                  keyboardType: TextInputType.number,
                  callback: (value) => setState(() => tamanho = value),
                  validator: (value) => isSenhaCaracteresInt(value!),
                ),
                SizedBox(height: _height),
                Button3dWidget(
                  callback: (value) => _gerarSenha(),
                  texto: SENHA_GERAR,
                ),
                if (senhaGerada.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        TituloText(texto: senhaGerada),
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
      floatingActionButton: !senhaGerada.isNotEmpty
          ? null
          : FloatingActionButton(
              onPressed: () => widget._callback(senhaGerada),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UiBorda.arredondada)),
              child: const Icon(UniconsLine.check),
            ),
    );
  }
}
