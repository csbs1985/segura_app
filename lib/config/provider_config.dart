import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:senha_app/config/auth_config.dart';
import 'package:senha_app/config/local_auth_config.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider<AuthConfig>(
    create: (context) => AuthConfig(),
  ),
  Provider<LocalAuthClass>(
    create: (context) => LocalAuthClass(auth: LocalAuthentication()),
  ),
];
