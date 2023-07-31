import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/appbar/home_appbar.dart';
import 'package:segura_app/button/floating_button.dart';
import 'package:segura_app/firestore/notes.firestore.dart';
import 'package:segura_app/page/drawer_page.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/skeleton/note_skeleton.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/note_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteFirestore _noteFirestore = NoteFirestore();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _keyUp(String value) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerPage(),
      appBar: AppBar(toolbarHeight: 0),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: UiSize.homeAppbar),
              child: FirestoreListView(
                query: _noteFirestore.getAllNotes(currentUser.value.userId),
                pageSize: 30,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                loadingBuilder: (context) => const NoteSkeleton(),
                errorBuilder: (context, error, _) => const NoteSkeleton(),
                emptyBuilder: (context) => const NoteSkeleton(),
                itemBuilder: (
                  BuildContext context,
                  QueryDocumentSnapshot<dynamic> snapshot,
                ) {
                  Map<String, dynamic> note = snapshot.data();
                  return NoteItemWidget(
                    item: note,
                    onTap: () => context.pushNamed(
                      RouteEnum.NOTE.value,
                      pathParameters: {'noteId': note['noteId']},
                    ),
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
        callback: () => context.pushNamed(
          RouteEnum.NOTE.value,
          pathParameters: {'noteId': EMPTY},
        ),
        icon: Icons.add,
      ),
    );
  }
}
