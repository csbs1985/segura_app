import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senha_app/appbar/voltar_appbar.dart';
import 'package:senha_app/button/3d_button.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';

class DoarPage extends StatefulWidget {
  const DoarPage({super.key});

  @override
  State<DoarPage> createState() => _DoarPageState();
}

class _DoarPageState extends State<DoarPage> {
  final ToastClass _toastClass = ToastClass();

  void _copiarPix(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: PIX_CODIGO));
    _toastClass.erro(
      context: context,
      texto: PIX_COPIADO,
    );
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
              const SubtituloText(texto: DOAR),
              const SizedBox(height: 16),
              const TextoText(texto: DOAR_DESCRICAO),
              const SizedBox(height: 40),
              Button3dButton(
                callback: (value) => _copiarPix(context),
                texto: DOAR_BUTTON,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
