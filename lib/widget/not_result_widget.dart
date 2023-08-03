import 'package:flutter/material.dart';
import 'package:segura_app/service/text_service.dart';

class NotResultWidget extends StatelessWidget {
  const NotResultWidget({
    super.key,
    required double altura,
  }) : _altura = altura;

  final double _altura;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: _altura,
      child: Center(
        child: Text(
          NOT_RESULT,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
