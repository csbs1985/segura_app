import 'package:flutter/material.dart';
import 'package:senha_app/appbar/modal_appbar.dart';
import 'package:senha_app/button/floating_button.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/widget/item_compartilhar_widget.dart';
import 'package:senha_app/widget/padrao_input.dart';
import 'package:unicons/unicons.dart';

class CompartilharModal extends StatefulWidget {
  const CompartilharModal({super.key});

  @override
  State<CompartilharModal> createState() => _CompartilharModalState();
}

class _CompartilharModalState extends State<CompartilharModal> {
  List<Map<String, dynamic>> mock = [
    {
      'avatarUsuario':
          "https://scontent.fcgh3-1.fna.fbcdn.net/v/t39.30808-6/321435001_718771036226780_7356593860379165830_n.jpg?_nc_cat=111&cb=99be929b-59f725be&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGQDXIiC35X1BzVNaJaUyGt-s6TjNF5z0n6zpOM0XnPScvxzPLXgGRJw6RiyMfO8xNTKoGsdi7lQZudbKqsOZqa&_nc_ohc=rkP9b5ghw70AX-29kmd&_nc_ht=scontent.fcgh3-1.fna&oh=00_AfDYZ8qLFiL0oQ7drdFhsc3RIgK_U2A3twsjxVdUywEbyQ&oe=649F7924",
      'emailUsuario': "sabrinainacio92@gmail.com",
      'idUsuario': "0123456789",
      'nomeUsuario': "Sabrina Inacio",
    },
    {
      'avatarUsuario':
          "https://scontent.fcgh3-1.fna.fbcdn.net/v/t1.18169-9/10930887_757777377641531_3555458299120246722_n.jpg?_nc_cat=109&cb=99be929b-59f725be&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG-aIqqoIu3GEc7pZjbFZERV1SUZCbDdvxXVJRkJsN2_ANx0fd1XYmTrG88_nKFjB6FzHtpF8fbIaVP3m4_gawu&_nc_ohc=6nmDpk5c6vAAX-1ieXX&_nc_ht=scontent.fcgh3-1.fna&oh=00_AfCNmbFTJTq0_MZV0dzhOvYz20t8SHaz0beAp3wpD-zHCQ&oe=64C10DE3",
      'emailUsuario': "tiago.guinho@gmail.com",
      'idUsuario': "abcdefhg",
      'nomeUsuario': "Tiago Guinho",
    },
  ];

  void _salvarCampartilhar(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModalAppbar(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubtituloText(texto: COMPATILHAR),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: PadraoInput(
                hintText: COMPATILHAR_HINT,
              ),
            ),
            const SizedBox(height: 24),
            const TextoText(texto: PESQUISAR_EMAIL),
            const SizedBox(height: 16),
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 4),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mock.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemCompartilharWidget(
                  isAdicionar: true,
                  usuario: mock[index],
                );
              },
            ),
            if (mock.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const TextoText(texto: COMPATILHADO),
                  const SizedBox(height: 16),
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 4),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mock.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemCompartilharWidget(
                        isAdicionar: false,
                        usuario: mock[index],
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(
        callback: () => _salvarCampartilhar(context),
        icone: UniconsLine.check,
      ),
    );
  }
}
