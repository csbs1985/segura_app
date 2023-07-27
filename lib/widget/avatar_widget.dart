import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_imagem.dart';
import 'package:senha_app/theme/ui_tamanho.dart';

class AvatarButton extends StatefulWidget {
  const AvatarButton({
    super.key,
    Function? callback,
    double? size,
  })  : _callback = callback,
        _size = size;

  final Function? _callback;

  final double? _size;

  @override
  State<AvatarButton> createState() => _AvatarButtonState();
}

class _AvatarButtonState extends State<AvatarButton> {
  void _onTap() {
    if (widget._callback != null) widget._callback!();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UiBorda.circulo),
        child: CachedNetworkImage(
          imageUrl: currentUsuario.value.avatarUsuario,
          width: widget._size ?? UiTamanho.avatar,
          height: widget._size ?? UiTamanho.avatar,
          errorWidget: (context, url, error) => avatar(),
          placeholder: (context, imageProvider) => avatar(),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget avatar() {
    return SizedBox(
      width: widget._size ?? UiTamanho.avatar,
      height: widget._size ?? UiTamanho.avatar,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UiBorda.circulo),
        child: Image.asset(
          UiImagem.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
