import 'package:flutter/material.dart';
import 'package:segura_app/element/user_element.dart';
import 'package:segura_app/service/shared_service.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({
    super.key,
    required Function callback,
    double? size,
  })  : _callback = callback,
        _size = size;

  final Function _callback;
  final double? _size;

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  final SharedService _sharedService = SharedService();

  List<String> usersList = [];

  _fetchUser() async {
    usersList = await _sharedService.getAllSharedLists();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUser(),
      builder: (context, users) {
        return Wrap(
          runSpacing: 8,
          spacing: 8,
          children: usersList.map((item) {
            return UserElement(
              callback: (value) => widget._callback(value),
              element: item,
              size: widget._size,
            );
          }).toList(),
        );
      },
    );
  }
}
