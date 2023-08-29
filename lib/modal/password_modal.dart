import 'package:flutter/material.dart';
import 'package:segura_app/class/password_class.dart';
import 'package:segura_app/widget/password_widget.dart';

class PasswordModal extends StatefulWidget {
  const PasswordModal({
    super.key,
    required Function callback,
    required Map<String, dynamic> note,
  })  : _callback = callback,
        _note = note;

  final Function _callback;
  final Map<String, dynamic> _note;

  @override
  State<PasswordModal> createState() => _PasswordModalState();
}

class _PasswordModalState extends State<PasswordModal> {
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: PasswordWidget(
                type: PasswordTypeEnum.MODAL,
                callback: (value) => setState(() => _password = value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
