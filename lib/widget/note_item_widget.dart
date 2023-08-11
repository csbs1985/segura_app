import 'package:flutter/material.dart';
import 'package:segura_app/class/color_class.dart';
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
    final ColorClass colorClass = ColorClass();

    return Container(
      constraints: const BoxConstraints(minHeight: UiSize.itemList),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiBorder.rounded),
        onTap: () => _onTap(),
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _item["color"] == 0
                ? null
                : colorClass.getBackgroundColor(_item["color"]),
            borderRadius: BorderRadius.circular(UiBorder.rounded),
            border: _item["color"] == 0
                ? Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  )
                : null,
          ),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          duration: const Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_item["title"] != "")
                RichText(
                  text: TextSpan(
                    text: _item["title"],
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (_item["note"] != "" && _item["title"] != "")
                const SizedBox(height: 8),
              if (_item["note"] != "")
                RichText(
                  text: TextSpan(
                    text: _item["note"],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
