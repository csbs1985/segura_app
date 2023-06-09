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
import 'package:senha_app/widget/lixeira_item_widget.dart';
import 'package:senha_app/widget/resultado_erro_widget.dart';
import 'package:senha_app/widget/resultado_vazio_widget.dart';
import 'package:unicons/unicons.dart';

class LixeiraPage extends StatefulWidget {
  const LixeiraPage({super.key});

  @override
  State<LixeiraPage> createState() => _LixeiraPageState();
}

class _LixeiraPageState extends State<LixeiraPage> {
  final SenhaFirestore _senhaFirestore = SenhaFirestore();

  void _abrirModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const LixeiraModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconeButton(
          icone: UniconsLine.arrow_left,
          callback: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconeButton(
            icone: UniconsLine.ellipsis_h,
            callback: () => _abrirModal(context),
          ),
          const SizedBox(width: 0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FirestoreListView(
              query: _senhaFirestore
                  .getTodasSenhasLixeira(currentUsuario.value.idUsuario),
              pageSize: 30,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) => const SenhaItemSkeleton(),
              errorBuilder: (context, error, _) =>
                  ErroResultadoWidget(altura: altura),
              emptyBuilder: (context) => ResultadoVazioWidget(altura: altura),
              itemBuilder: (
                BuildContext context,
                QueryDocumentSnapshot<dynamic> snapshot,
              ) {
                Map<String, dynamic> senha = snapshot.data();

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: LixeiraItemWidget(senha: senha),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
