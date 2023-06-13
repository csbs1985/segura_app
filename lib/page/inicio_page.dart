import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:senha_app/appbar/inicio_appbar.dart';
import 'package:senha_app/class/pesquisar_class.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/class/usuario_class.dart';
import 'package:senha_app/config/algolia_config.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/firestore/senha_firestore.dart';
import 'package:senha_app/page/drawer_page.dart';
import 'package:senha_app/skeleton/senha_item_skeleton.dart';
import 'package:senha_app/text/titulo_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/avatar_widget.dart';
import 'package:senha_app/widget/pesquisar_widget.dart';
import 'package:senha_app/widget/resultado_erro_widget.dart';
import 'package:senha_app/widget/resultado_vazio_widget.dart';
import 'package:senha_app/widget/senha_item_widget.dart';
import 'package:unicons/unicons.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PesquisarClass _pesquisarClass = PesquisarClass();
  final SenhaFirestore _senhaFirestore = SenhaFirestore();

  Algolia? algoliaSenha;

  List<Map<String, dynamic>> _snapshotSenha = [];

  bool isPesquisar = false;

  @override
  void initState() {
    algoliaSenha = AlgoliaConfig.algoliaSenha;
    super.initState();
  }

  void _keyUp(String value) async {
    _snapshotSenha = [];
    setState(() => isPesquisar = true);

    if (value.length > 2) {
      if (algoliaSenha != null) {
        AlgoliaQuery query =
            algoliaSenha!.instance.index('segura_senhas').query(value);

        query = query
            .setOptionalFilter('idUsuario:${currentUsuario.value.idUsuario}');

        AlgoliaQuerySnapshot snap = await query.getObjects();

        setState(() {
          if (snap.hits.isNotEmpty)
            _snapshotSenha = _pesquisarClass.converterLista(snap.hits);
          if (value.isEmpty) _snapshotSenha = [];
        });
      }
    } else
      setState(() => isPesquisar = false);
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.sizeOf(context).height - (UiTamanho.appbar * 4);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(toolbarHeight: 0),
      endDrawer: const DrawerPage(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: isPesquisar
                ? PesquisarWidget(senha: _snapshotSenha)
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 88, 24, 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TituloText(texto: SEGURA),
                            GestureDetector(
                              onTap: () =>
                                  scaffoldKey.currentState!.openEndDrawer(),
                              child: const AvatarWidget(),
                            ),
                          ],
                        ),
                      ),
                      FirestoreListView(
                        query: _senhaFirestore
                            .getTodasSenhas(currentUsuario.value.idUsuario),
                        pageSize: 30,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        loadingBuilder: (context) => const SenhaItemSkeleton(),
                        errorBuilder: (context, error, _) =>
                            ErroResultadoWidget(altura: altura),
                        emptyBuilder: (context) =>
                            ResultadoVazioWidget(altura: altura),
                        itemBuilder: (
                          BuildContext context,
                          QueryDocumentSnapshot<dynamic> snapshot,
                        ) {
                          Map<String, dynamic> senha = snapshot.data();
                          return SenhaItemWidget(senha: senha);
                        },
                      ),
                    ],
                  ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: InicioAppbar(
              callback: (value) => _keyUp(value),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RoutesEnum.SENHA.value,
            pathParameters: {'idSenha': EMPTY}),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UiBorda.arredondada)),
        child: const Icon(UniconsLine.plus),
      ),
    );
  }
}
