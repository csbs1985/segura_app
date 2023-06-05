import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/config/constante_config.dart';
import 'package:senha_app/skeleton/favicon_skeleton.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/theme/ui_tema.dart';

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(RoutesEnum.SENHA.value,
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
                      Text(
                        widget._senha["nome"],
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Row(
                        children: [
                          Text(
                            widget._senha["oculto"]
                                ? SENHA_ASTERISCO
                                : widget._senha["senha"],
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            _senhaClass.ultimaAlteracaoSenha(
                                widget._senha["dataRegistro"]),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
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
