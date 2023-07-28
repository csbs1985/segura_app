import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:segura_app/service/hive_service.dart';
import 'package:segura_app/service/routes_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await HiveService.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: goRoute.routerDelegate,
      routeInformationParser: goRoute.routeInformationParser,
      routeInformationProvider: goRoute.routeInformationProvider,
      // darkTheme: UiTema.temaEscuro,
      // theme: UiTema.tema,
    );
  }
}
