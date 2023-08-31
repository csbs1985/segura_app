import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:segura_app/firestore/user_firestore.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_image.dart';
import 'package:segura_app/theme/ui_size.dart';

class AvatarButton extends StatefulWidget {
  const AvatarButton({
    super.key,
    Function? callback,
    double? size,
    required String userId,
  })  : _callback = callback,
        _size = size,
        _userId = userId;

  final Function? _callback;
  final String _userId;
  final double? _size;

  @override
  State<AvatarButton> createState() => _AvatarButtonState();
}

class _AvatarButtonState extends State<AvatarButton> {
  final UserFirestore _userFirestore = UserFirestore();

  Map<String, dynamic> _user = {};

  Future<void> _fetchUser() async {
    _user = {};

    final result = await _userFirestore.getCategoryId(widget._userId);
    Map<String, dynamic> item =
        result.docs.first.data() as Map<String, dynamic>;
    _user = item;
  }

  void _onTap() {
    if (widget._callback != null) widget._callback!();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUser(),
      builder: (BuildContext context, _) {
        return GestureDetector(
          onTap: () => _onTap(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(UiBorder.circle),
            child: _user.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: _user['userAvatar'],
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
                  )
                : avatar(),
          ),
        );
      },
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
