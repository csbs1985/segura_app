import 'package:flutter/material.dart';
import 'package:senha_app/appbar/voltar_appbar.dart';
import 'package:senha_app/button/floating_button.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/firestore/relatar_problema_firebase.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/widget/padrao_input.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

class RelatarProblemaPage extends StatefulWidget {
  const RelatarProblemaPage({super.key});

  @override
  State<RelatarProblemaPage> createState() => _RelatarProblemaPageState();
}

class _RelatarProblemaPageState extends State<RelatarProblemaPage> {
  final RelatarProblemaFirestore _relatarProblemaFirestore =
      RelatarProblemaFirestore();
  final TextEditingController _controleProblema = TextEditingController();
  final ToastClass _toastClass = ToastClass();
  final Uuid uuid = const Uuid();

  String relatarProblema = "";

  void _salvarProblema(BuildContext context) async {
    try {
      Map<String, dynamic> problema = {
        'idProblema': uuid.v4(),
        "dataRegistro": DateTime.now().toString(),
        "idUsuario": currentUsuario.value.idUsuario,
        "texto": relatarProblema,
      };
      await _relatarProblemaFirestore.salvarProblema(problema);
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.SUCESSO.value,
        texto: RELATAR_PROBLEMA_SUCESSO,
      );
      _controleProblema.clear();
    } catch (e) {
      _toastClass.abrirToast(
        context: context,
        estilo: SenhaEnum.ERRO.value,
        texto: RELATAR_PROBLEMA_ERRO,
      );
    }
  }

  @override
  void dispose() {
    _controleProblema.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltarAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubtituloText(texto: RELATAR_PROBLEMA),
              const SizedBox(height: 16),
              const TextoText(texto: RELATAR_PROBLEMA_DESCRICAO),
              const SizedBox(height: 16),
              PadraoInput(
                controller: _controleProblema,
                hintText: RELATAR_PROBLEMA,
                maxLines: null,
                minLines: 1,
                callback: (value) => setState(() => relatarProblema = value),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: relatarProblema.isEmpty
          ? null
          : FloatingButton(
              callback: () => _salvarProblema(context),
              icone: UniconsLine.check,
            ),
    );
  }
}
