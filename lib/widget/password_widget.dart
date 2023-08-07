import 'package:flutter/material.dart';
import 'package:segura_app/button/primary_button.dart';
import 'package:segura_app/class/password_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/widget/default_input.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required Function callback,
    required PasswordTypeEnum type,
  })  : _callback = callback,
        _type = type;

  final Function _callback;
  final PasswordTypeEnum _type;

  @override
  State<PasswordWidget> createState() => _GerarSenhaModalState();
}

class _GerarSenhaModalState extends State<PasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final SenhaClass _senhaClass = SenhaClass();
  final TextEditingController _controllerTamanho = TextEditingController();

  final String _senhaGerada = "";
  String tamanho = "8";
  bool isSelecionado = true;
  List<String> listaSelecionado = [PasswordEnum.MINUSCULA.name];

  final double _height = 16;

  @override
  void initState() {
    super.initState();
    _controllerTamanho.text = tamanho;
  }

  void _gerarSenha() {
    // if (_formKey.currentState!.validate()) {
    //   if (isSelecionado) {
    //     setState(() => _senhaGerada =
    //         _senhaClass.gerarSenha(listaSelecionado, int.parse(tamanho)));
    //     FocusScope.of(context).unfocus();
    //   } else {
    //     setState(() => _senhaGerada = "");
    //   }

    //   widget._callback(_senhaGerada);
    // }
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
                Text(
                  NOTE_GENERATE,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: _height),
                Text(
                  NOTE_DESCRIPTION,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: _height),
                Text(
                  NOTE_CHARACTERS,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: _height),
                // PadraoSelecionarWidget(
                //   callback: (value) => _verificaSelecionados(value),
                // ),
                // if (!isSelecionado) ErroText(SENHA_CARACTERES_ERRO),
                SizedBox(height: _height),
                Text(
                  NOTE_SIZE,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: _height),
                DefaultInput(
                  controller: _controllerTamanho,
                  keyboardType: TextInputType.number,
                  callback: (value) => setState(() => tamanho = value),
                  // validator: (value) => isSenhaCaracteresInt(value!),
                ),
                SizedBox(height: _height),
                PrimaryButton(
                  callback: (value) => _gerarSenha(),
                  text: NOTE_CREATED,
                ),
                if (_senhaGerada.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Text(_senhaGerada),
                        const Text(NOTE_CREATED),
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
