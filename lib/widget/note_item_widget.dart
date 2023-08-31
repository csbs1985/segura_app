import 'package:flutter/material.dart';
import 'package:segura_app/button/avatar_button.dart';
import 'package:segura_app/class/color_class.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/category_item_widget.dart';

class NoteItemWidget extends StatefulWidget {
  const NoteItemWidget({
    super.key,
    required Map<String, dynamic> item,
    required Function onTap,
  })  : _item = item,
        _onTap = onTap;

  final Map<String, dynamic> _item;
  final Function _onTap;

  @override
  State<NoteItemWidget> createState() => _NoteItemWidgetState();
}

class _NoteItemWidgetState extends State<NoteItemWidget> {
  final ColorClass _colorClass = ColorClass();

  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: UiSize.itemList),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiBorder.rounded),
        onTap: () => widget._onTap(),
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: widget._item["color"] == 0
                ? null
                : _colorClass.getBackgroundColor(widget._item["color"]),
            borderRadius: BorderRadius.circular(UiBorder.rounded),
            border: widget._item["color"] == 0
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
              if (widget._item["title"] != "")
                RichText(
                  text: TextSpan(
                    text: widget._item["title"],
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (widget._item["note"] != "" && widget._item["title"] != "")
                const SizedBox(height: 8),
              if (widget._item["note"] != "")
                RichText(
                  text: TextSpan(
                    text: widget._item["note"],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              Row(
                children: [
                  if (widget._item["category"].isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: widget._item["category"].map<Widget>((item) {
                          return CategoryItemWidget(
                            category: item as String,
                            isSmall: true,
                          );
                        }).toList(),
                      ),
                    ),
                  if (widget._item["category"].isNotEmpty &&
                      widget._item["shared"].isNotEmpty)
                    const SizedBox(width: 8),
                  if (widget._item["shared"].isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: widget._item["shared"].map<Widget>((item) {
                          return AvatarButton(
                            userId: item as String,
                            size: 28,
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
