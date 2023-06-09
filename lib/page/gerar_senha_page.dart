import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:senha_app/modal/lixeira_modal.dart';
import 'package:senha_app/skeleton/senha_item_skeleton.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/resultado_erro_widget.dart';
import 'package:senha_app/widget/resultado_vazio_widget.dart';
import 'package:senha_app/widget/senha_item_widget.dart';
import 'package:unicons/unicons.dart';

class GerarSenhaPage extends StatefulWidget {
  const GerarSenhaPage({super.key});

  @override
  State<GerarSenhaPage> createState() => _GerarSenhaPageState();
}

class _GerarSenhaPageState extends State<GerarSenhaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconeButton(
          icone: UniconsLine.arrow_left,
          callback: () => Navigator.of(context).pop(),
        ),
        actions: const [],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
