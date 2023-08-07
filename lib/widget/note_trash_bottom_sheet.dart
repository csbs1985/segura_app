import 'package:flutter/material.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/modal/trash_item_modal.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:unicons/unicons.dart';

class NoteTrashBottomSheet extends StatefulWidget {
  const NoteTrashBottomSheet({
    super.key,
    required Function callback,
    required Map<String, dynamic> note,
  })  : _callback = callback,
        _note = note;

  final Function _callback;
  final Map<String, dynamic> _note;

  @override
  State<NoteTrashBottomSheet> createState() => _NoteTrashBottomSheetState();
}

class _NoteTrashBottomSheetState extends State<NoteTrashBottomSheet> {
  _openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiColor.overlay,
      shape: UiBorder.borderModal,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) => TrashItemModal(noteId: widget._note['noteId']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ValueListenableBuilder(
        valueListenable: currentNote,
        builder: (BuildContext context, NoteModel note, _) {
          return Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TRASH_NOT,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SvgButton(
                  icon: UniconsLine.ellipsis_v,
                  callback: () => _openModal(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
