import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:unicons/unicons.dart';

class RelatarProblemaPage extends StatefulWidget {
  const RelatarProblemaPage({super.key});

  @override
  State<RelatarProblemaPage> createState() => _RelatarProblemaPageState();
}

class _RelatarProblemaPageState extends State<RelatarProblemaPage> {
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
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SubtituloText(texto: RELATAR_PROBLEMA),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
