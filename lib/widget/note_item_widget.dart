import 'package:flutter/material.dart';
import 'package:segura_app/class/color_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
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
  final CategoryFirestore _categoryFirestore = CategoryFirestore();

  List<Map<String, dynamic>> _listCategories = [];

  int index = 1;

  Future<void> _fetchCategory() async {
    _listCategories = [];

    for (var category in widget._item["category"]) {
      final result = await _categoryFirestore.getCategoryId(category);
      Map<String, dynamic> item =
          result.docs.first.data() as Map<String, dynamic>;
      _listCategories.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchCategory(),
      builder: (BuildContext context, _) {
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
                  if (_listCategories.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: _listCategories.map((item) {
                          return CategoryItemWidget(
                            category: item,
                            isSmall: true,
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
