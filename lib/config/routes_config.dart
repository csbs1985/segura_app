import 'package:go_router/go_router.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/config/auth_config.dart';
import 'package:senha_app/page/entrar_page.dart';
import 'package:senha_app/page/inicio_page.dart';
import 'package:senha_app/page/senha_page.dart';

final AuthConfig _authConfig = AuthConfig();

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutesEnum.INICIO.value,
  refreshListenable: _authConfig,
  redirect: (context, state) {
    final usuario = _authConfig.usuario;
    final isLoginRoute = state.matchedLocation == RoutesEnum.ENTRAR.value;

    if (usuario == null) {
      return isLoginRoute ? null : RoutesEnum.ENTRAR.value;
    }
    if (isLoginRoute) return RoutesEnum.INICIO.value;
    return null;
  },
  routes: [
    GoRoute(
      name: RoutesEnum.SENHA.value,
      path: "/senha/:idSenha",
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: SenhaPage(idSenha: state.pathParameters["idSenha"]!),
      ),
    ),
    GoRoute(
      path: RoutesEnum.ENTRAR.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const EntrarPage(),
      ),
    ),
    GoRoute(
      path: RoutesEnum.INICIO.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const InicioPage(),
      ),
    ),
  ],
);
