import 'package:flutter/material.dart';
import 'package:segura_app/service/text_service.dart';

class NoteEmptyWidget extends StatelessWidget {
  const NoteEmptyWidget({
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
          NOTE_EMPTY,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
