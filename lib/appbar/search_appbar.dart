import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/input/default_input.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:unicons/unicons.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgButton(
          callback: () => context.pop(),
          icon: UniconsLine.arrow_left,
        ),
        Expanded(
          child: SizedBox(
            height: 48,
            child: DefaultInput(
              onSaved: (value) => widget._callback(value),
              hintText: SEARCH,
              isCircle: true,
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
