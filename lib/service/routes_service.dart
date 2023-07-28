import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/page/home_page.dart';
import 'package:segura_app/page/login_page.dart';
import 'package:segura_app/page/splash_page.dart';

final GoRouter goRoute = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouteEnum.SPLASH.value,
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
      path: RouteEnum.SPLASH.value,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
  ],
);

enum RouteEnum {
  HOME('/home'),
  LOGIN('/login'),
  SPLASH('/splash');

  final String value;
  const RouteEnum(this.value);
}
