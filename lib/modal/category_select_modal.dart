import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:segura_app/appbar/modal_appbar.dart';
import 'package:segura_app/class/category_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/modal/category_form_modal.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/skeleton/category_skeleton.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/message_widget.dart';

class CategorySelectModal extends StatefulWidget {
  const CategorySelectModal({
    super.key,
    required Function callback,
    required Map<String, dynamic> note,
  })  : _callback = callback,
        _note = note;

  final Function _callback;
  final Map<String, dynamic> _note;

  @override
  State<CategorySelectModal> createState() => _CategorySelectModalState();
}

class _CategorySelectModalState extends State<CategorySelectModal> {
  final CategoryClass _categoryClass = CategoryClass();
  final CategoryFirestore _categoryFirestore = CategoryFirestore();

  List<dynamic> _listCategories = [];

  @override
  void initState() {
    _listCategories = widget._note['category'];
    currentCategories.value = widget._note['category'];
    super.initState();
  }

  void _openModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overlay,
      shape: UiBorder.borderModal,
      builder: (context) => const CategoryFormModal(select: {}),
    );
  }

  void _selectCategory(BuildContext context, Map<String, dynamic> category) {
    String categoryId = category['categoryId'];

    final List<String> updatedCategories = List.from(currentCategories.value);
    if (updatedCategories.contains(categoryId)) {
      updatedCategories.remove(categoryId);
    } else {
      updatedCategories.add(categoryId);
    }

    currentCategories.value = updatedCategories;
    widget._callback(currentCategories.value);
  }

  bool isCategory(String categoryId) {
    return _listCategories.contains(categoryId) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - (UiSize.appbar * 4);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ModalAppBar(
                callback: () => _openModal(context),
                isAdd: true,
                text: CATEGORIES,
              ),
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

                    return ValueListenableBuilder<List<dynamic>>(
                      valueListenable: currentCategories,
                      builder: (context, selectedCategories, child) {
                        return Wrap(
                          runSpacing: 8,
                          spacing: 8,
                          children: listaCategorias.map((item) {
                            return GestureDetector(
                              onTap: () => _selectCategory(context, item),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                decoration: BoxDecoration(
                                  color: selectedCategories
                                          .contains(item['categoryId'])
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .chipTheme
                                          .backgroundColor,
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
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
