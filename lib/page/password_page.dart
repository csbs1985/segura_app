import 'package:flutter/material.dart';
import 'package:segura_app/appbar/back_appbar.dart';
import 'package:segura_app/button/primary_button.dart';
import 'package:segura_app/class/copy_class.dart';
import 'package:segura_app/class/password_class.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/widget/password_widget.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => PasswordaPageState();
}

class PasswordaPageState extends State<PasswordPage> {
  final CopyClass _copyClass = CopyClass();

  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: PasswordWidget(
        type: PasswordTypeEnum.PAGE,
        callback: (value) => setState(() => _password = value),
      ),
      floatingActionButton: _password.isEmpty
          ? null
          : PrimaryButton(
              callback: () => _copyClass.copy(
                context: context,
                text: _password,
              ),
              text: NOTE_COPY,
            ),
    );
  }
}
