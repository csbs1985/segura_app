import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_tamanho.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CategoriaSkeleton extends StatelessWidget {
  const CategoriaSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, __) {
        bool isEscuro = tema == Brightness.dark;

        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width: 80,
                height: UiTamanho.categoria,
                textColor: isEscuro ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              const SizedBox(width: 8),
              Skeleton(
                width: 80,
                height: UiTamanho.categoria,
                textColor: isEscuro ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
              const SizedBox(width: 8),
              Skeleton(
                width: 80,
                height: UiTamanho.categoria,
                textColor: isEscuro ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.arredondada),
              ),
            ],
          ),
        );
      },
    );
  }
}
