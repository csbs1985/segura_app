import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segura_app/appbar/back_appbar.dart';
import 'package:segura_app/button/primary_button.dart';
import 'package:segura_app/class/toast_class.dart';
import 'package:segura_app/service/text_service.dart';

class DoarPage extends StatefulWidget {
  const DoarPage({super.key});

  @override
  State<DoarPage> createState() => _DoarPageState();
}

class _DoarPageState extends State<DoarPage> {
  final ToastClass _toastClass = ToastClass();

  void _copiPix(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: PIX_CODE));
    _toastClass.sucesso(
      context: context,
      text: PIX_COPY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DONATE,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                DONATE_DESCRIPTION,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                callback: () => _copiPix(context),
                text: DONATE_BUTTON,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
