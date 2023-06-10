import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:unicons/unicons.dart';

class DoarPage extends StatefulWidget {
  const DoarPage({super.key});

  @override
  State<DoarPage> createState() => _DoarPageState();
}

class _DoarPageState extends State<DoarPage> {
  final ToastClass _toastClass = ToastClass();

  void _copiarPix(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: PIX_CODIGO));
    _toastClass.abrirToast(
      context: context,
      estilo: SenhaEnum.SUCESSO.value,
      texto: PIX_COPIADO,
    );
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubtituloText(texto: DOAR),
              SizedBox(height: 16),
              TextoText(texto: DOAR_DESCRICAO),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _copiarPix(context),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UiBorda.arredondada)),
        child: const Icon(UniconsLine.copy),
      ),
    );
  }
}
