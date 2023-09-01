import 'package:flutter/material.dart';
import 'package:segura_app/button/avatar_button.dart';

class UserElement extends StatefulWidget {
  const UserElement({
    super.key,
    required Function callback,
    required String element,
    double? size,
  })  : _callback = callback,
        _element = element,
        _size = size;

  final Function _callback;
  final String _element;

  final double? _size;

  @override
  State<UserElement> createState() => _UserElementState();
}

class _UserElementState extends State<UserElement> {
  @override
  Widget build(BuildContext context) {
    return AvatarButton(
      callback: () => widget._callback(widget._element),
      userId: widget._element,
      size: widget._size,
    );
  }
}
