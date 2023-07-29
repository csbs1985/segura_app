import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_image.dart';
import 'package:segura_app/theme/ui_size.dart';

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
        borderRadius: BorderRadius.circular(UiBorder.circle),
        child: CachedNetworkImage(
          imageUrl: currentUser.value.userAvatar,
          width: widget._size ?? UiSize.avatar,
          height: widget._size ?? UiSize.avatar,
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
      width: widget._size ?? UiSize.avatar,
      height: widget._size ?? UiSize.avatar,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(UiBorder.circle),
        child: Image.asset(
          UiImage.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
