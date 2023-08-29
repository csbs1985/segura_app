import 'package:flutter/material.dart';
import 'package:segura_app/class/password_class.dart';
import 'package:segura_app/widget/password_widget.dart';

class PasswordModal extends StatefulWidget {
  const PasswordModal({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<PasswordModal> createState() => _PasswordModalState();
}

class _PasswordModalState extends State<PasswordModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            SizedBox(
              height: MediaQuery.sizeOf(context).height - 64,
              child: PasswordWidget(
                type: PasswordTypeEnum.MODAL,
                callback: (value) => widget._callback(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
