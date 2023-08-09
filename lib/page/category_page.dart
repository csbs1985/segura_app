import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:segura_app/skeleton/category_skeleton.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/widget/message_widget.dart';
import 'package:unicons/unicons.dart';

import 'package:segura_app/appbar/back_appbar.dart';
import 'package:segura_app/button/floating_button.dart';
import 'package:segura_app/class/category_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/modal/category_form_modal.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_size.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final CategoryFirestore _categoryFirestore = CategoryFirestore();
  final CategoryClass _categoryClass = CategoryClass();

  void _openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiColor.overlay,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (context) => const CategoryFormModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - (UiSize.appbar * 4);

    return Scaffold(
      appBar: const BackAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                CATEGORIES,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _categoryFirestore
                    .snapshotsCategory(currentUser.value.userId),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
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
                          onTap: () {
                            // Handle onTap
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).chipTheme.backgroundColor,
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
      ),
      floatingActionButton: FloatingButton(
        callback: () => _openModal(context),
        icon: UniconsLine.plus,
      ),
    );
  }
}
