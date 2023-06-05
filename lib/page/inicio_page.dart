import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:senha_app/widget/padrao_input.dart';
import 'package:senha_app/widget/senha_item_widget.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final SenhaFirestore _senhaFirestore = SenhaFirestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 64,
        title: Text(
          "Senhas",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: const [
          Icon(LineIcons.horizontalEllipsis),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: PadraoInput(
                  callback: (value) => {
                    print(value),
                  },
                  hintText: PESQUISAR,
                  pesquisar: true,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FirestoreListView(
                    query: _senhaFirestore.getTodasSenhasUsuario(
                        "03b4940b-7aff-425c-b093-3ec4af22d11f"),
                    pageSize: 30,
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // loadingBuilder: (context) => const HistoriaItemSkeleton(),
                    // errorBuilder: (context, error, _) =>
                    //     ErroResultadoWidget(altura: _altura),
                    // emptyBuilder: (context) => SemResultadoWidget(altura: _altura),
                    itemBuilder: (
                      BuildContext context,
                      QueryDocumentSnapshot<dynamic> snapshot,
                    ) {
                      Map<String, dynamic> senha = snapshot.data();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: SenhaItemWidget(senha: senha),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(RoutesEnum.SENHA.value,
            pathParameters: {'idSenha': "nova_senha"}),
        child: const Icon(Icons.add),
      ),
    );
  }
}
