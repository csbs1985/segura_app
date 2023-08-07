import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/page/category_page.dart';
import 'package:segura_app/page/donate_page.dart';
import 'package:segura_app/page/home_page.dart';
import 'package:segura_app/page/login_page.dart';
import 'package:segura_app/page/auth_page.dart';
import 'package:segura_app/page/menu_page.dart';
import 'package:segura_app/page/note_page.dart';
import 'package:segura_app/page/password_page.dart';
import 'package:segura_app/page/report_page.dart';
import 'package:segura_app/page/trash_page.dart';

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
      path: RouteEnum.CATEGORY.value,
      builder: (BuildContext context, GoRouterState state) {
        return const CategoryPage();
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
      path: RouteEnum.MENU.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const MenuPage(),
      ),
    ),
    GoRoute(
      name: RouteEnum.NOTE.value,
      path: "/note/:type",
      builder: (BuildContext context, GoRouterState state) {
        return NotePage(type: state.pathParameters["type"]!);
      },
    ),
    GoRoute(
      path: RouteEnum.PASSWORD.value,
      builder: (BuildContext context, GoRouterState state) {
        return const PasswordPage();
      },
    ),
    GoRoute(
      path: RouteEnum.REPORT.value,
      builder: (BuildContext context, GoRouterState state) {
        return const ReportPage();
      },
    ),
    GoRoute(
      path: RouteEnum.TRASH.value,
      builder: (BuildContext context, GoRouterState state) {
        return const TrashPage();
      },
    ),
  ],
);

enum RouteEnum {
  AUTH('/auth'),
  CATEGORY('/category'),
  DONATE('/donate'),
  HOME('/home'),
  LOGIN('/login'),
  NOTE('note'),
  MENU('/menu'),
  PASSWORD('/password'),
  REPORT('/perport'),
  TRASH('/trash');

  final String value;
  const RouteEnum(this.value);
}

CustomTransitionPage transicaoPaginas<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: child,
    ),
  );
}
