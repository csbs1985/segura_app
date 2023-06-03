import 'package:go_router/go_router.dart';
import 'package:senha_app/class/route_class.dart';
import 'package:senha_app/config/auth_config.dart';
import 'package:senha_app/page/entrar_page.dart';
import 'package:senha_app/page/inicio_page.dart';
import 'package:senha_app/page/senha_page.dart';

final AuthConfig _authConfig = AuthConfig();

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: RouteEnum.INICIO.value,
  routes: [
    GoRoute(
      name: RouteEnum.SENHA.value,
      path: '/atividade/:idUsuario',
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: SenhaPage(idSenha: state.pathParameters['idSenha']!),
      ),
    ),
    GoRoute(
      path: RouteEnum.ENTRAR.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const EntrarPage(),
      ),
    ),
    GoRoute(
      path: RouteEnum.INICIO.value,
      pageBuilder: (context, state) => transicaoPaginas(
        context: context,
        state: state,
        child: const InicioPage(),
      ),
    ),
  ],
);
