import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/button/primary_button.dart';
import 'package:segura_app/button/second_button.dart';
import 'package:segura_app/firestore/user_firestore.dart';
import 'package:segura_app/hive/user_hive.dart';
import 'package:segura_app/model/user_model.dart';
import 'package:segura_app/service/auth_service.dart';
import 'package:segura_app/service/local_auth_service.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_icon.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService _authService = AuthService();
  final LocalAuthService _localAuthService = LocalAuthService();
  final UserFirestore _userFirestore = UserFirestore();
  final UserHive _userHive = UserHive();

  @override
  void initState() {
    super.initState();
    checkUserExistence();
  }

  Future<void> checkUserExistence() async {
    final userExists = await _userHive.doesUserExist();

    if (userExists) {
      final Map<dynamic, dynamic>? user = await _userHive.getUser();

      if (user != null) {
        initAuthenticate();
        _saveUser(user);
      }
    } else {
      final user = await _authService.signInWithGoogle();
      Map<String, dynamic>? userMap = user?.toMap();

      await _userFirestore.saveUser(userMap!);
      await _userHive.saveUser(userMap);

      final isLocalAuthRequired = await _localAuthService.isFirstTimeOpening();

      if (isLocalAuthRequired) {
        initAuthenticate();
        _saveUser(userMap);
      }
    }
  }

  void _saveUser(Map<dynamic, dynamic> user) {
    currentUser.value = UserModel(
      userAvatar: user['userAvatar'],
      userId: user['userId'],
      userName: user['userName'],
      userEmail: user['userEmail'],
    );
  }

  initAuthenticate() async {
    final isAuthenticated = await _localAuthService.authenticate(context);
    final String currentRoute = ModalRoute.of(context)!.settings.name!;

    if (isAuthenticated != null) {
      (currentRoute == RouteEnum.AUTH.value ||
              currentRoute == RouteEnum.LOGIN.value)
          ? context.push(RouteEnum.HOME.value)
          : context.pushReplacementNamed(currentRoute);
    }
  }

  _logout() async {
    await _authService.signOut();
    context.push(RouteEnum.LOGIN.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        children: [
          Expanded(
            child: SvgPicture.asset(
              UiIcon.logo,
              height: MediaQuery.sizeOf(context).width / 3,
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width / 1.5,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Column(
                children: [
                  PrimaryButton(
                    callback: () => initAuthenticate(),
                    text: USE_PHONE,
                  ),
                  const SizedBox(height: 8),
                  SecondButton(
                    callback: () => _logout(),
                    text: ENTER_OTHER,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
