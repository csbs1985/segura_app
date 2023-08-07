import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:segura_app/button/avatar_button.dart';
import 'package:segura_app/button/list_button.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/service/auth_service.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_size.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final AuthService _authService = AuthService();
  final NoteClass _noteClass = NoteClass();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    _setVersion();
    super.initState();
  }

  Future<void> _setVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AvatarButton(size: 48),
                  const SizedBox(height: 24),
                  Text(
                    currentUser.value.userName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: UiSize.spaceList),
                  Text(currentUser.value.userEmail),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            ListButton(
              text: NOTE_CREATE,
              icon: Icons.content_paste_outlined,
              callback: () => {
                _noteClass.deleteNote(),
                context.push(RouteEnum.NOTE.value),
              },
            ),
            const SizedBox(height: UiSize.spaceList),
            ListButton(
              text: PASSWORD_GENERATE,
              icon: Icons.password_outlined,
              callback: () => context.push(RouteEnum.PASSWORD.value),
            ),
            const SizedBox(height: UiSize.spaceList),
            ListButton(
              text: CATEGORIES,
              icon: Icons.label_outlined,
              callback: () => context.push(RouteEnum.CATEGORIES.value),
            ),
            const SizedBox(height: UiSize.spaceList),
            ListButton(
              text: TRASH,
              icon: Icons.delete_outlined,
              callback: () => context.push(RouteEnum.TRASH.value),
            ),
            const SizedBox(height: UiSize.spaceList),
            ListButton(
              text: DONATE,
              icon: Icons.favorite_border_outlined,
              callback: () => context.push(RouteEnum.DONATE.value),
            ),
            const SizedBox(height: UiSize.spaceList),
            ListButton(
              text: REPORT_PROBLEM,
              icon: Icons.report_problem_outlined,
              callback: () => context.push(RouteEnum.REPORT_PROBLEM.value),
            ),
            const SizedBox(height: 24),
            ListButton(
              text: EXIT,
              icon: Icons.door_back_door_outlined,
              callback: () => _authService.signOut(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
        child: Text(
          '$BY${_packageInfo.version}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
