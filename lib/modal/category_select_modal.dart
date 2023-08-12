import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/appbar/modal_appbar.dart';
import 'package:segura_app/class/category_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/skeleton/category_skeleton.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/message_widget.dart';
import 'package:uuid/uuid.dart';

class CategorySelectModal extends StatefulWidget {
  const CategorySelectModal({
    super.key,
    required Map<String, dynamic> note,
  }) : _note = note;

  final Map<String, dynamic> _note;

  @override
  State<CategorySelectModal> createState() => _CategorySelectModalState();
}

class _CategorySelectModalState extends State<CategorySelectModal> {
  final CategoryClass _categoryClass = CategoryClass();
  final CategoryFirestore _categoryFirestore = CategoryFirestore();
  final NoteClass _noteClass = NoteClass();
  final Uuid _uuid = const Uuid();

  List<dynamic> _listCategories = [];
  List<dynamic> _listCategoriesCurrent = [];

  final Map<String, dynamic> _formCategory = {};

  @override
  void initState() {
    _listCategories = widget._note['category'];
    _listCategoriesCurrent = widget._note['category'];
    super.initState();
  }

  void _selectCategory(BuildContext context, Map<String, dynamic> category) {
    String categoryId = category['categoryId'];

    setState(() {
      if (_listCategories.contains(categoryId)) {
        _listCategories.remove(categoryId);
      } else {
        _listCategories.add(categoryId);
      }
    });
  }

  bool isCategory(String categoryId) {
    return _listCategories.contains(categoryId) ? true : false;
  }

  void _saveCategory() {
    if (_listCategoriesCurrent != _listCategories) {
      _noteClass.saveCategoryNote(
          context, widget._note['noteId'], _listCategories);
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - (UiSize.appbar * 4);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ModalAppBar(text: CATEGORIES),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: _categoryFirestore
                  .snapshotsCategory(currentUser.value.userId),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CategorySkeleton();
                } else if (!snapshot.hasData ||
                    snapshot.data?.docs.isEmpty == true) {
                  return MessageWidget(
                    height: height,
                    text: CATEGORY_EMPTY,
                  );
                } else {
                  List<Map<String, dynamic>> listaCategorias = _categoryClass
                      .converterQuerySnapshotToList(snapshot.data!.docs);

                  return Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: listaCategorias.map((item) {
                      return GestureDetector(
                        onTap: () => _selectCategory(context, item),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                          decoration: BoxDecoration(
                            color: isCategory(item['categoryId'])
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).chipTheme.backgroundColor,
                            borderRadius:
                                BorderRadius.circular(UiBorder.rounded),
                          ),
                          child: Text(
                            item['category'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
