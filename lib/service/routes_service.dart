import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/page/donate_page.dart';
import 'package:segura_app/page/home_page.dart';
import 'package:segura_app/page/login_page.dart';
import 'package:segura_app/page/auth_page.dart';
import 'package:segura_app/page/note_page.dart';
import 'package:segura_app/page/report_page.dart';

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
      path: RouteEnum.AUTH.value,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      path: RouteEnum.DONATE.value,
      builder: (BuildContext context, GoRouterState state) {
        return const DoarPage();
      },
    ),
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
      name: RouteEnum.NOTE.value,
      path: "/note/:note",
      builder: (BuildContext context, GoRouterState state) {
        return NotePage(noteId: state.pathParameters["note"]!);
      },
    ),
    GoRoute(
      path: RouteEnum.REPORT_PROBLEM.value,
      builder: (BuildContext context, GoRouterState state) {
        return const ReportPage();
      },
    ),
  ],
);

enum RouteEnum {
  AUTH('/auth'),
  CATEGORIES('/categories'),
  DONATE('/donate'),
  HOME('/home'),
  LOGIN('/login'),
  NOTE('/note'),
  PASSWORD('/password'),
  PASSWORD_GENERATE('/password_generate'),
  REPORT_PROBLEM('/perport'),
  TRASH('/trash');

  final String value;
  const RouteEnum(this.value);
}
