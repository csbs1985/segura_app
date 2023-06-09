import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:unicons/unicons.dart';

class ModoEntradaPage extends StatefulWidget {
  const ModoEntradaPage({super.key});

  @override
  State<ModoEntradaPage> createState() => _ModoEntradaPageState();
}

class _ModoEntradaPageState extends State<ModoEntradaPage> {
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
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SubtituloText(texto: MODO_ENTRADA),
            ),
          ],
        ),
      ),
    );
  }
}
