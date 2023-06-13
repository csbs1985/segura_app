import 'package:flutter/material.dart';
import 'package:senha_app/config/value_notifier_config.dart';
import 'package:senha_app/theme/ui_borda.dart';
import 'package:senha_app/theme/ui_cor.dart';
import 'package:senha_app/theme/ui_espaco.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class SenhaItemSkeleton extends StatelessWidget {
  const SenhaItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, __) {
        bool isEscuro = tema == Brightness.dark;

        return Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width: 32,
                height: 32,
                textColor: isEscuro ? UiCor.skeletonEscuro : UiCor.skeleton,
                borderRadius: BorderRadius.circular(UiBorda.circulo),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    width: 200,
                    height: 16,
                    textColor: isEscuro ? UiCor.skeletonEscuro : UiCor.skeleton,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                  const SizedBox(height: UiEspaco.medio),
                  Skeleton(
                    width: MediaQuery.sizeOf(context).width - 80,
                    height: 12,
                    textColor: isEscuro ? UiCor.skeletonEscuro : UiCor.skeleton,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                  const SizedBox(height: UiEspaco.medio),
                  Skeleton(
                    width: 120,
                    height: 24,
                    textColor: isEscuro ? UiCor.skeletonEscuro : UiCor.skeleton,
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
