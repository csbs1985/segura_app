import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_text.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required String text,
  }) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: Text(
        _text,
        style: UiText.error,
      ),
    );
  }
}
