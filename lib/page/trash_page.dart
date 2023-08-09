import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:segura_app/appbar/back_appbar.dart';
import 'package:segura_app/bottom/trash_bottom.dart';
import 'package:segura_app/firestore/note_firestore.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/service/routes_service.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/skeleton/note_skeleton.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:segura_app/widget/message_widget.dart';
import 'package:segura_app/widget/note_item_widget.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  final NoteFirestore _noteFirestore = NoteFirestore();

  Map<String, dynamic> _note = {};

  bool _isBottom() {
    return _note.isNotEmpty ? true : false;
  }

  Future<void> _selectNote(Map<String, dynamic> note) async {
    currentNote.value = NoteModel.fromMap(note);
    context.push(RouteEnum.NOTE_TRASH.value);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height - (UiSize.appbar * 4);

    return Scaffold(
      appBar: const BackAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    TRASH,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                FirestoreListView(
                  query: _noteFirestore.getAllTrashes(currentUser.value.userId),
                  pageSize: 30,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  loadingBuilder: (context) => const NoteSkeleton(),
                  errorBuilder: (context, error, _) => const NoteSkeleton(),
                  emptyBuilder: (context) => MessageWidget(
                    height: height,
                    text: TRASH_EMPTY,
                  ),
                  itemBuilder: (
                    BuildContext context,
                    QueryDocumentSnapshot<dynamic> snapshot,
                  ) {
                    _note = snapshot.data();
                    return NoteItemWidget(
                      item: _note,
                      onTap: () => _selectNote(_note),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _isBottom() ? TrashBottom(note: _note) : null,
    );
  }
}
