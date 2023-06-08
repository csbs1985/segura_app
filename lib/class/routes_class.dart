import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

enum RoutesEnum {
  BIOMETRIA('/biometria'),
  ENTRAR('/entrar'),
  GERAR_SENHA('/gerar_senha'),
  INICIO('/inicio'),
  LIXEIRA('/lixeira'),
  SENHA('senha');

  final String value;
  const RoutesEnum(this.value);
}
