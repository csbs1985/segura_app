import 'package:flutter/material.dart';

class LegendaText extends StatelessWidget {
  const LegendaText({
    super.key,
    required String texto,
  }) : _texto = texto;

  final String _texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _texto,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
