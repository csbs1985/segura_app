import 'package:flutter/material.dart';
import 'package:senha_app/class/senha_class.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:senha_app/theme/ui_tema.dart';
import 'package:unicons/unicons.dart';

class FaviconWidget extends StatefulWidget {
  const FaviconWidget({
    super.key,
    String? url,
  }) : _url = url;

  final String? _url;

  @override
  State<FaviconWidget> createState() => _FaviconWidgetState();
}

class _FaviconWidgetState extends State<FaviconWidget> {
  final SenhaClass _senhaClass = SenhaClass();

  bool isLoading = true;
  String? faviconUrl;

  @override
  void initState() {
    super.initState();
    definirFavicon();
  }

  definirFavicon() {
    if (widget._url! != "") {
      _senhaClass.definirFavicon(widget._url!).then((url) {
        setState(() => faviconUrl = url);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark;

        return SizedBox(
          height: UiTamanho.favicon,
          child: isLoading
              ? Icon(
                  widget._url! != "" ? Icons.public : UniconsLine.shield_check,
                  color: isEscuro ? UiCor.iconeEscuro : UiCor.icone)
              : Image.network(faviconUrl!),
        );
      },
    );
  }
}
