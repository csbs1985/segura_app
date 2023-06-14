import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_cor.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isEscuro = tema == Brightness.dark ? false : true;

        return Center(
          child: SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              color: UiCor.segunda,
              backgroundColor: isEscuro ? UiCor.fundoEscuro : UiCor.fundo,
            ),
          ),
        );
      },
    );
  }
}
