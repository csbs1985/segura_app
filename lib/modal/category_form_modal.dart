import 'package:flutter/material.dart';
import 'package:segura_app/button/square_button.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/widget/default_input.dart';
import 'package:unicons/unicons.dart';

class CategoryFormModal extends StatefulWidget {
  const CategoryFormModal({
    super.key,
    Map<String, dynamic>? select,
  }) : _select = select;

  final Map<String, dynamic>? _select;

  @override
  State<CategoryFormModal> createState() => _CategoryFormModalState();
}

class _CategoryFormModalState extends State<CategoryFormModal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiBorder.rounded),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget._select!.isEmpty ? CATEGORY_EDIT : CATEGORY_CREATE,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget._select!.isEmpty
                        ? CATEGORY_EDIT_DESCRIPTION
                        : CATEGORY_CREATE_DESCRIPTION,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: DefaultInput(),
                      ),
                      const SizedBox(width: 8),
                      SquareButton(
                        callback: () => {},
                        icon: UniconsLine.check,
                        isPrimary: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiBorder.rounded),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CATEGORY_DELETE,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    CATEGORY_DELETE_DESCRIPTION,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SquareButton(
                        callback: () => {},
                        icon: UniconsLine.times,
                        isPrimary: false,
                      ),
                      const SizedBox(width: 8),
                      SquareButton(
                        callback: () => {},
                        icon: UniconsLine.check,
                        isPrimary: true,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
