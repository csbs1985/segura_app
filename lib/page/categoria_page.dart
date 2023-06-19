import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senha_app/appbar/voltar_appbar.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/firestore/usuario_firestore.dart';
import 'package:senha_app/model/usuario_model.dart';
import 'package:senha_app/skeleton/cateroria_skeleton%20copy.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/widget/lista_categoria_widget.dart';
import 'package:senha_app/widget/resultado_vazio_widget.dart';

class CategoriaPage extends StatefulWidget {
  const CategoriaPage({super.key});

  @override
  State<CategoriaPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height - (UiTamanho.appbar * 4);

    return Scaffold(
      appBar: const VoltarAppbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubtituloText(texto: CATEGORIAS),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: _usuarioFirestore.receberTodasCategoriasUsuario(
                    currentUsuario.value.idUsuario),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return ResultadoVazioWidget(altura: altura);
                    case ConnectionState.waiting:
                      return const CategoriaSkeleton();
                    case ConnectionState.done:
                    default:
                      Map<String, dynamic> usuario =
                          UsuarioModel.toMap(snapshot.data!.docs[0]);

                      return ItemCategoriaWidget(
                        categoria: usuario['categorias'],
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
