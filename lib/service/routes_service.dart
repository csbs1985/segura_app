import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/page/home_page.dart';
import 'package:segura_app/page/login_page.dart';
import 'package:segura_app/page/auth_page.dart';

final UserHive _userHive = UserHive();

final GoRouter goRoute = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouteEnum.AUTH.value,
  redirect: (context, state) async {
    final bool userExists = await _userHive.doesUserExist();

    if (state.uri.toString() == '/') {
      return userExists ? RouteEnum.HOME.value : RouteEnum.LOGIN.value;
    }
    return state.uri.toString();
  },
  routes: <RouteBase>[
    GoRoute(
      path: RouteEnum.HOME.value,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: RouteEnum.LOGIN.value,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: RouteEnum.AUTH.value,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),
  ],
);

enum RouteEnum {
  AUTH('/auth'),
  HOME('/home'),
  LOGIN('/login'),
  NOTE('/note');

  final String value;
  const RouteEnum(this.value);
}
