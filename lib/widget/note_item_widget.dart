import 'package:flutter/material.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_size.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget({
    super.key,
    required Map<String, dynamic> item,
    required Function onTap,
  })  : _item = item,
        _onTap = onTap;

  final Map<String, dynamic> _item;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: UiSize.itemList),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiBorder.rounded),
        onTap: () => _onTap(),
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UiBorder.rounded),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          duration: const Duration(milliseconds: 500),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _item["note"],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
