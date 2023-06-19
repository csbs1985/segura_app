import 'package:go_router/go_router.dart';
import 'package:senha_app/class/routes_class.dart';
import 'package:senha_app/config/auth_config.dart';
import 'package:senha_app/page/categoria_page.dart';
import 'package:senha_app/page/doar_page.dart';
import 'package:senha_app/page/entrar_page.dart';
import 'package:senha_app/page/gerar_senha_page.dart';
import 'package:senha_app/page/inicio_page.dart';
import 'package:senha_app/page/lixeira_page.dart';
import 'package:senha_app/page/local_auth_page.dart';
import 'package:senha_app/page/definir_page.dart';
import 'package:senha_app/page/relatar_problema_page.dart';
import 'package:senha_app/page/senha_page.dart';

final AuthConfig _authConfig = AuthConfig();

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RoutesEnum.INICIO.value,
  refreshListenable: _authConfig,
  redirect: (context, state) {
    final usuario = _authConfig.usuario;
    final isLoginRoute = state.matchedLocation == RoutesEnum.ENTRAR.value;

    if (usuario == null) return isLoginRoute ? null : RoutesEnum.ENTRAR.value;
    if (isLoginRoute) return RoutesEnum.INICIO.value;
    return null;
  },
  routes: [
    GoRoute(
      path: RoutesEnum.CATEGORIA.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const CategoriaPage(),
      ),
    ),
    GoRoute(
      path: RoutesEnum.DEFINIR.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const DefinirPage(),
      ),
    ),
    GoRoute(
      path: RoutesEnum.DOAR.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const DoarPage(),
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
      path: RoutesEnum.GERAR_SENHA.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const GerarSenhaPage(),
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
    GoRoute(
      path: RoutesEnum.LIXEIRA.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const LixeiraPage(),
      ),
    ),
    GoRoute(
      path: RoutesEnum.LOCAL_AUTH.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const LocalAuthPage(),
      ),
    ),
    GoRoute(
      path: RoutesEnum.RELATAR_PROBLEMA.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const RelatarProblemaPage(),
      ),
    ),
    GoRoute(
      name: RoutesEnum.SENHA.value,
      path: "/senha/:idSenha",
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: SenhaPage(idSenha: state.pathParameters["idSenha"]!),
      ),
    ),
  ],
);
