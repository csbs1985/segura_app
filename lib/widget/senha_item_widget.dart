import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/class/toast_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/skeleton/favicon_skeleton.dart';
import 'package:senha_app/text/legenda_text.dart';
import 'package:senha_app/text/texto_text.dart';
import 'package:senha_app/text/subtitulo_text.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/theme/ui_tema.dart';
import 'package:flutter/services.dart';

class SenhaItemWidget extends StatefulWidget {
  const SenhaItemWidget({
    super.key,
    required Map<String, dynamic> senha,
  }) : _senha = senha;

  final Map<String, dynamic> _senha;

  @override
  State<SenhaItemWidget> createState() => _SenhaItemWidgetState();
}

class _SenhaItemWidgetState extends State<SenhaItemWidget> {
  final SenhaClass _senhaClass = SenhaClass();
  final ToastClass _toastClass = ToastClass();

  String faviconUrl = "";
  String title = "";

  @override
  void initState() {
    super.initState();
    definirFavicon();
  }

  definirFavicon() {
    _senhaClass.definirFavicon(widget._senha["link"]).then((url) {
      setState(() => faviconUrl = url);
    });
  }

  void copiarSenha(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget._senha["senha"]));
    _toastClass.abrirToast(
      context: context,
      estilo: SenhaEnum.SUCESSO.value,
      texto: SENHA_COPIADA,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(UiBorda.arredondada),
      onLongPress: () => copiarSenha(context),
      onTap: () => context.pushNamed(RoutesEnum.SENHA.value,
          pathParameters: {'idSenha': widget._senha['idSenha']}),
      child: ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isEscuro = tema == Brightness.dark;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorda.arredondada),
              border: Border.all(
                color: isEscuro ? UiCor.bordaEscura : UiCor.borda,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget._senha["link"] != "")
                  SizedBox(
                    height: UiTamanho.favicon,
                    child: faviconUrl.isNotEmpty
                        ? Image.network(faviconUrl)
                        : const FaviconSkeleton(),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget._senha["nome"] != "")
                        TextoText(texto: widget._senha["nome"]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                        child: LegendaText(
                          texto: _senhaClass.ultimaAlteracaoSenha(
                              widget._senha["dataRegistro"]),
                        ),
                      ),
                      if (!widget._senha["oculto"])
                        SubtituloText(texto: widget._senha["senha"]),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
