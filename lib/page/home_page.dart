import 'dart:io';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/appbar/home_appbar.dart';
import 'package:segura_app/button/floating_button.dart';
import 'package:segura_app/class/search_class.dart';
import 'package:segura_app/firestore/note.firestore.dart';
import 'package:segura_app/model/note_modal.dart';
import 'package:segura_app/page/drawer_page.dart';
import 'package:segura_app/service/algolia_service.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/skeleton/note_skeleton.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/message_widget.dart';
import 'package:segura_app/widget/note_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NoteFirestore _noteFirestore = NoteFirestore();
  final SearchClass _searchClass = SearchClass();

  Algolia? algoliaSegura;

  List<Map<String, dynamic>> lisNote = [];

  bool isPesquisar = false;

  @override
  void initState() {
    algoliaSegura = AlgoliaService.algoliaSegura;
    super.initState();
  }

  void _keyUp(String value) async {
    lisNote = [];
    setState(() => isPesquisar = true);

    if (value.length > 2) {
      if (algoliaSegura != null) {
        AlgoliaQuery query =
            algoliaSegura!.instance.index('segura_notes').query(value);

        query = query.setOptionalFilter('userId:${currentUser.value.userId}');

        AlgoliaQuerySnapshot snap = await query.getObjects();

        setState(() {
          if (snap.hits.isNotEmpty) {
            lisNote = _searchClass.convertListToMaps(snap.hits);
          }
          if (value.isEmpty) lisNote = [];
        });
      }
    } else {
      setState(() => isPesquisar = false);
    }
  }

  Future<void> _selectNote(Map<String, dynamic> note) async {
    currentNote.value = NoteModel.fromMap(note);
    context.push(RouteEnum.NOTE.value);
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.sizeOf(context).height - (UiSize.appbar * 4);

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        key: scaffoldKey,
        drawer: const DrawerPage(),
        appBar: AppBar(toolbarHeight: 0),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: isPesquisar
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: UiSize.homeAppbar),
                      child: lisNote.isEmpty
                          ? MessageWidget(
                              altura: altura,
                              text: NOT_RESULT,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: lisNote.length,
                              itemBuilder: (BuildContext context, int index) {
                                return NoteItemWidget(
                                  item: lisNote[index],
                                  onTap: () => _selectNote(lisNote[index]),
                                );
                              },
                            ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: UiSize.homeAppbar),
                      child: FirestoreListView(
                        query: _noteFirestore
                            .getAllNotes(currentUser.value.userId),
                        pageSize: 30,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        loadingBuilder: (context) => const NoteSkeleton(),
                        errorBuilder: (context, error, _) =>
                            const NoteSkeleton(),
                        emptyBuilder: (context) => MessageWidget(
                          altura: altura,
                          text: NOTE_EMPTY,
                        ),
                        itemBuilder: (
                          BuildContext context,
                          QueryDocumentSnapshot<dynamic> snapshot,
                        ) {
                          Map<String, dynamic> note = snapshot.data();
                          return NoteItemWidget(
                            item: note,
                            onTap: () => _selectNote(note),
                          );
                        },
                      ),
                    ),
            ),
            Positioned(
              top: 8,
              left: 16,
              right: 16,
              child: HomeAppBar(
                avatar: () => scaffoldKey.currentState!.openDrawer(),
                search: (value) => _keyUp(value),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingButton(
          callback: () => context.push(RouteEnum.NOTE.value),
          icon: Icons.add,
        ),
      ),
    );
  }
}
