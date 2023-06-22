import 'package:flutter/material.dart';
import 'package:senha_app/appbar/modal_appbar.dart';
import 'package:senha_app/button/segundo_button.dart';
import 'package:senha_app/class/categoria_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/widget/padrao_input.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

class CategoriaFormModal extends StatefulWidget {
  const CategoriaFormModal({super.key});

  @override
  State<CategoriaFormModal> createState() => _CategoriaFormModalState();
}

class _CategoriaFormModalState extends State<CategoriaFormModal> {
  final CategoriaClass _categoriaClass = CategoriaClass();
  final TextEditingController _controller = TextEditingController();
  final Uuid _uuid = const Uuid();

  String _texto = "";

  void salvarCategoriaUsuario(BuildContext context) {
    if (_texto.isNotEmpty) {
      _controller.text = _texto;

      Map<String, dynamic> _categorias = {
        "idCategoria": _uuid.v4(),
        "idUsuario": currentUsuario.value.idUsuario,
        "textoCategoria": _texto.trim().toLowerCase()
      };

      _categoriaClass.salvarCategoria(context, _categorias);
      _controller.clear();
      _texto = "";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark;

        return Scaffold(
          appBar: const ModalAppbar(),
          body: SingleChildScrollView(
            child: Container(
              color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SubtituloText(texto: CATEGORIA_CRIAR),
                  const SizedBox(height: 16),
                  const TextoText(texto: CATEGORIA_DESCRICAO),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PadraoInput(
                          hintText: CATEGORIA,
                          controller: _controller,
                          callback: (value) => setState(() => _texto = value),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SegundolButton(
                        icone: UniconsLine.check,
                        callback: () => salvarCategoriaUsuario(context),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
