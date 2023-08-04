import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';

class NoteSkeleton extends StatelessWidget {
  const NoteSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              border: Border.all(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              border: Border.all(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              border: Border.all(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
