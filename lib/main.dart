import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:segura_app/service/hive_service.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/theme/ui_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await HiveService.start();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    UiTheme.definirTema();
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    UiTheme.definirTema();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: goRoute.routerDelegate,
      routeInformationParser: goRoute.routeInformationParser,
      routeInformationProvider: goRoute.routeInformationProvider,
      theme: UiTheme.theme,
      darkTheme: UiTheme.themeDark,
    );
  }
}
