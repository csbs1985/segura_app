import 'package:flutter/material.dart';
import 'package:segura_app/button/avatar_button.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/widget/default_input.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
    required Function avatar,
    required Function search,
  })  : _avatar = avatar,
        _search = search;

  final Function _avatar;
  final Function _search;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(UiBorder.circle),
      ),
      child: Row(
        children: [
          Expanded(
            child: DefaultInput(
              callback: (value) => widget._search(value),
              hintText: SEARCH,
              inputCircle: true,
              prefixIcon: Icons.search_outlined,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: GestureDetector(
              onTap: () => widget._avatar(),
              child: AvatarButton(callback: () => widget._avatar()),
            ),
          ),
        ],
      ),
    );
  }
}
