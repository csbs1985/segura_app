import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class NoteSkeleton extends StatelessWidget {
  const NoteSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Skeleton(
            width: double.infinity,
            height: 80,
            textColor: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          const SizedBox(height: 8),
          Skeleton(
            width: double.infinity,
            height: 80,
            textColor: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          const SizedBox(height: 8),
          Skeleton(
            width: double.infinity,
            height: 80,
            textColor: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
        ],
      ),
    );
  }
}
