import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/avatar_button.dart';
import 'package:segura_app/button/search_button.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_border.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

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
            child: SearchButton(
              callback: () => context.push(RouteEnum.SEARCH.value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: AvatarButton(
              userId: currentUser.value.userId,
              callback: () => context.push(RouteEnum.MENU.value),
            ),
          ),
        ],
      ),
    );
  }
}
