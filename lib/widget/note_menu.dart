import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/copy_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/modal/category_select_modal.dart';
import 'package:segura_app/modal/palette_modal.dart';
import 'package:segura_app/modal/password_modal.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/theme/ui_size.dart';
import 'package:unicons/unicons.dart';

class NoteMenu extends StatefulWidget {
  const NoteMenu({
    super.key,
    required Function callback,
    required Map<String, dynamic> note,
  })  : _callback = callback,
        _note = note;

  final Function _callback;
  final Map<String, dynamic> _note;

  @override
  State<NoteMenu> createState() => _NoteBottomState();
}

class _NoteBottomState extends State<NoteMenu> {
  final CopyClass _copyClass = CopyClass();
  final NoteClass _noteClass = NoteClass();

  bool _isCopy() {
    return (widget._note['note'].isNotEmpty) ? true : false;
  }

  _copyNote() {
    _copyClass.copy(
      context: context,
      text: widget._note['note'],
    );
  }

  _deleteNote(BuildContext context) {
    widget._note['noteId'] != ""
        ? _noteClass.noteExcludedTrue(context, currentNote.value.noteId)
        : context.pop();
  }

  _openPaletteModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: UiColor.overlay,
      shape: UiBorder.borderModal,
      builder: (context) => PaletteModal(
        callback: (value) => _setColor(value),
        color: widget._note['color'],
      ),
    );
  }

  _setColor(int value) {
    Future(() => setState(() {
          widget._note['color'] = value;
          widget._callback(widget._note);
        }));
  }

  _openPasswordModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiColor.overlay,
      shape: UiBorder.borderModal,
      builder: (context) => PasswordModal(
        callback: (value) => _setPassword(value),
      ),
    );
  }

  _openCategoryModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiColor.overlay,
      shape: UiBorder.borderModal,
      builder: (context) => CategorySelectModal(
        callback: (value) => _setCategory(value),
        note: widget._note,
      ),
    );
  }

  _setCategory(List<String> value) {
    Future(() => setState(() {
          widget._note['category'] = value;
          widget._callback(widget._note);
        }));
  }

  _setPassword(String value) {
    String text = "${widget._note['note']}\n$PASSWORD: $value";
    setState(() => widget._note['note'] = text);
    widget._callback(widget._note);
    context.pop();
  }

  _openSharedModal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UiSize.icon,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgButton(
                  icon: UniconsLine.palette,
                  callback: () => _openPaletteModal(context),
                ),
                SvgButton(
                  icon: UniconsLine.asterisk,
                  callback: () => _openPasswordModal(context),
                ),
                SvgButton(
                  icon: UniconsLine.label,
                  callback: () => _openCategoryModal(context),
                ),
                SvgButton(
                  icon: UniconsLine.user_plus,
                  callback: () => _openSharedModal(context),
                ),
                if (_isCopy())
                  SvgButton(
                    icon: UniconsLine.copy,
                    callback: () => _copyNote(),
                  ),
                SvgButton(
                  icon: UniconsLine.trash_alt,
                  callback: () => _deleteNote(context),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
