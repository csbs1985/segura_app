import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:segura_app/class/category_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/skeleton/category_skeleton.dart';
import 'package:segura_app/widget/category_list_widget.dart';
import 'package:segura_app/widget/message_widget.dart';
import 'package:segura_app/widget/color_select_widget.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final CategoryClass _categoryClass = CategoryClass();
  final CategoryFirestore _categoryFirestore = CategoryFirestore();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            CATEGORIES,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:
                _categoryFirestore.snapshotsCategory(currentUser.value.userId),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CategorySkeleton();
              } else if (!snapshot.hasData ||
                  snapshot.data?.docs.isEmpty == true) {
                return const MessageWidget(
                  height: 300,
                  text: CATEGORY_EMPTY,
                );
              } else {
                List<Map<String, dynamic>> listCategories = _categoryClass
                    .converterQuerySnapshotToList(snapshot.data!.docs);

                return CategoryListWidget(
                  callback: (value) => print(value),
                  categories: listCategories,
                );
              }
            },
          ),
          const SizedBox(height: 16),
          Text(
            PEOPLE,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            COLOR,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ColorSelectWidget(
            callback: (value) => print(value),
            color: 0,
          ),
        ],
      ),
    );
  }
}
