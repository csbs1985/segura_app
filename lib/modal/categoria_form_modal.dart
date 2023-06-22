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
  const CategoriaFormModal({
    super.key,
    Map<String, dynamic>? selecionado,
  }) : _selecionado = selecionado;

  final Map<String, dynamic>? _selecionado;

  @override
  State<CategoriaFormModal> createState() => _CategoriaFormModalState();
}

class _CategoriaFormModalState extends State<CategoriaFormModal> {
  final CategoriaClass _categoriaClass = CategoriaClass();
  final TextEditingController _controller = TextEditingController();

  final Uuid _uuid = const Uuid();

  String _texto = "";

  @override
  void initState() {
    if (widget._selecionado!.isNotEmpty)
      _controller.text = widget._selecionado!['textoCategoria'];
    super.initState();
  }

  void salvarCategoriaUsuario(BuildContext context) {
    if (_texto.isNotEmpty) {
      _controller.text = _texto;

      Map<String, dynamic> _categorias = {
        "idCategoria": widget._selecionado!.isNotEmpty
            ? widget._selecionado!['idCategoria']
            : _uuid.v4(),
        "idUsuario": currentUsuario.value.idUsuario,
        "textoCategoria": _texto.trim().toLowerCase()
      };

      _categoriaClass.salvarCategoria(context, _categorias);

      if (widget._selecionado!.isEmpty) {
        _controller.clear();
        _texto = "";
      }
      Navigator.of(context).pop();
    }
  }

  void _deletarCategoria(BuildContext context) {
    _categoriaClass.deletarCategoria(
        context, widget._selecionado!['idCategoria']);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ModalAppbar(),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: currentTema,
          builder: (BuildContext context, Brightness tema, _) {
            bool isEscuro = tema == Brightness.dark;

            return Container(
              color: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtituloText(
                      texto: widget._selecionado!.isEmpty
                          ? CATEGORIA_CRIAR
                          : CATEGORIA_EDITAR),
                  const SizedBox(height: 16),
                  TextoText(
                      texto: widget._selecionado!.isEmpty
                          ? CATEGORIA_CRIAR_DESCRICAO
                          : CATEGORIA_EDITAR_DESCRICAO),
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
                      const SizedBox(width: 16),
                      SegundolButton(
                        icone: UniconsLine.check,
                        callback: () => salvarCategoriaUsuario(context),
                      )
                    ],
                  ),
                  if (widget._selecionado!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const SubtituloText(texto: CATEGORIA_EXLUIR),
                        const SizedBox(height: 16),
                        const TextoText(texto: CATEGORIA_EXLUIR_DESCRICAO),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SegundolButton(
                              icone: UniconsLine.times,
                              callback: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 16),
                            SegundolButton(
                              callback: () => _deletarCategoria(context),
                              icone: UniconsLine.check,
                            )
                          ],
                        )
                      ],
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
