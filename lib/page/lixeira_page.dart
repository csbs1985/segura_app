import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:senha_app/button/icone_button.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:senha_app/modal/lixeira_modal.dart';
import 'package:senha_app/skeleton/senha_item_skeleton.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/item_lixeira_widget.dart';
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

  final List<String> _listaSenha = [];

  void _abrirModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => LixeiraModal(listaSenha: _listaSenha),
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
          if (_listaSenha.isNotEmpty)
            IconeButton(
              icone: UniconsLine.ellipsis_h,
              callback: () => _abrirModal(context),
            ),
          const SizedBox(width: 0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SubtituloText(texto: LIXEIRA),
            ),
            FirestoreListView(
              query: _senhaFirestore
                  .receberTodasSenhasLixeira(currentUsuario.value.idUsuario),
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
                _listaSenha.add(senha['idSenha']);

                return ItemLixeiraWidget(item: senha);
              },
            ),
          ],
        ),
      ),
    );
  }
}
