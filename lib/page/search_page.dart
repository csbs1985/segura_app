import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/appbar/search_appbar.dart';
import 'package:segura_app/class/category_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/class/search_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/service/algolia_service.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/skeleton/category_skeleton.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/category_item_widget.dart';
import 'package:segura_app/widget/message_widget.dart';
import 'package:segura_app/widget/note_item_widget.dart';
import 'package:segura_app/widget/select_color_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CategoryFirestore _categoryFirestore = CategoryFirestore();
  final CategoryClass _categoryClass = CategoryClass();
  final SearchClass _searchClass = SearchClass();

  Algolia? algoliaSegura;

  List<Map<String, dynamic>> listNote = [];
  List<Map<String, dynamic>> _listCategories = [];

  bool isSearch = false;

  @override
  void initState() {
    algoliaSegura = AlgoliaService.algoliaSegura;
    super.initState();
  }

  void _keyUp(String value) async {
    listNote = [];
    if (value.isNotEmpty) {
      setState(() => isSearch = true);
      if (value.length > 2) {
        if (algoliaSegura != null) {
          AlgoliaQuery query =
              algoliaSegura!.instance.index('segura_notes').query(value);

          query = query.setOptionalFilter('userId:${currentUser.value.userId}');

          AlgoliaQuerySnapshot snap = await query.getObjects();

          setState(() {
            if (snap.hits.isNotEmpty) {
              listNote = _searchClass.convertListToMaps(snap.hits);
            }
            if (value.isEmpty) listNote = [];
          });
        }
      }
    } else
      setState(() => isSearch = false);
  }

  Future<void> _selectNote(Map<String, dynamic> note) async {
    currentNote.value = NoteModel.fromMap(note);

    context.pushNamed(RouteEnum.NOTE.value,
        pathParameters: {'type': NoteTypeEnum.NOTE.name});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height - (UiSize.appbar * 4);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 2),
            SearchAppBar(
              callback: (value) => _keyUp(value),
            ),
            isSearch
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: UiSize.homeAppbar),
                    child: listNote.isEmpty
                        ? MessageWidget(
                            height: height,
                            text: NOT_RESULT,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listNote.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NoteItemWidget(
                                item: listNote[index],
                                onTap: () => _selectNote(listNote[index]),
                              );
                            },
                          ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        CATEGORIES,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: _categoryFirestore
                            .snapshotsCategory(currentUser.value.userId),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CategorySkeleton();
                          } else if (!snapshot.hasData ||
                              snapshot.data?.docs.isEmpty == true) {
                            return MessageWidget(
                              height: height,
                              text: CATEGORY_EMPTY,
                            );
                          } else {
                            _listCategories =
                                _categoryClass.converterQuerySnapshotToList(
                                    snapshot.data!.docs);

                            return Wrap(
                              runSpacing: 8,
                              spacing: 8,
                              children: _listCategories.map((item) {
                                return CategoryItemWidget(
                                  callback: () => {},
                                  category: item,
                                  isColor: true,
                                  isSmall: false,
                                );
                              }).toList(),
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
                      SelectColorWidget(
                        callback: (value) => {},
                        color: 0,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
