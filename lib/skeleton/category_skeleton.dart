import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_size.dart';

class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: [
          Container(
            width: 120,
            height: UiSize.chip,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              color: Theme.of(context).chipTheme.backgroundColor,
            ),
          ),
          Container(
            width: 80,
            height: UiSize.chip,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              color: Theme.of(context).chipTheme.backgroundColor,
            ),
          ),
          Container(
            width: 140,
            height: UiSize.chip,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              color: Theme.of(context).chipTheme.backgroundColor,
            ),
          ),
          Container(
            width: 80,
            height: UiSize.chip,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              color: Theme.of(context).chipTheme.backgroundColor,
            ),
          ),
          Container(
            width: 130,
            height: UiSize.chip,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
              color: Theme.of(context).chipTheme.backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
