import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/color_class.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/firestore/category_firestore.dart';
import 'package:segura_app/modal/category_select_modal.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/theme/ui_border.dart';
import 'package:segura_app/theme/ui_color.dart';
import 'package:segura_app/widget/category_item_widget.dart';
import 'package:segura_app/widget/form_input.dart';
import 'package:segura_app/widget/note_menu.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required String type,
  }) : _type = type;

  final String _type;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final ColorClass _colorClass = ColorClass();
  final CategoryFirestore _categoryFirestore = CategoryFirestore();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final NoteClass _noteClass = NoteClass();
  final Uuid _uuid = const Uuid();

  NoteModel? _noteCurrent;
  Map<String, dynamic> _noteForm = {};
  List<Map<String, dynamic>> _listCategories = [];

  @override
  void initState() {
    super.initState();
    _fetchNoteData();
  }

  Future<void> _fetchNoteData() async {
    if (currentNote.value.noteId.isNotEmpty) {
      _noteForm = {
        "category": currentNote.value.category,
        "color": currentNote.value.color,
        "dateRegistration": currentNote.value.dateRegistration,
        "excluded": currentNote.value.excluded,
        "noteId": currentNote.value.noteId,
        "note": currentNote.value.note,
        "position": currentNote.value.position,
        "shared": currentNote.value.shared,
        "title": currentNote.value.title,
        "userId": currentNote.value.userId,
      };

      _noteCurrent = currentNote.value;
    } else {
      _noteForm = {
        "category": [],
        "color": 0,
        "dateRegistration": "",
        "excluded": false,
        "noteId": "",
        "note": "",
        "position": 0,
        "shared": [],
        "title": "",
        "userId": "",
      };
    }
  }

  Future<void> _fetchCategory() async {
    _listCategories = [];

    for (var category in _noteForm["category"]) {
      final result = await _categoryFirestore.getCategoryId(category);
      Map<String, dynamic> item =
          result.docs.first.data() as Map<String, dynamic>;
      _listCategories.add(item);
    }
  }

  _saveNote(BuildContext context) {
    if (_noteForm['note'] != "" &&
        _noteForm['note'] != null &&
        _noteCurrent != _noteForm) {
      setState(() {
        if (currentNote.value.noteId.isNotEmpty) {
          // editar
          _noteForm = {
            "category": _noteForm['category'],
            "color": _noteForm['color'],
            "dateRegistration": _noteForm['dateRegistration'],
            "excluded": _noteForm['excluded'],
            "noteId": _noteForm['noteId'],
            "note": _noteForm['note'].trim(),
            "position": _noteForm['position'],
            "shared": _noteForm['shared'],
            "title": _noteForm['title'].trim(),
            "userId": currentUser.value.userId,
          };
        } else {
          // criar
          if (_noteForm['note'] != "" && _noteForm['note'] != null) {
            _noteForm = {
              "category": _noteForm['category'],
              "color": _noteForm['color'],
              "dateRegistration": DateTime.now().toString(),
              "excluded": false,
              "noteId": _uuid.v4(),
              "note": _noteForm['note'].trim(),
              "position": _noteForm['position'],
              "shared": _noteForm['shared'],
              "title": _noteForm['title'].trim(),
              "userId": currentUser.value.userId,
            };
          }
        }
      });

      _noteClass.saveNote(context, _noteForm);
      _noteClass.deleteNote();
    }
    context.pop();
  }

  _openCategoryModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiColor.overlay,
      shape: UiBorder.borderModal,
      builder: (context) => CategorySelectModal(
        callback: (value) => _noteForm['category'] = value,
        note: _noteForm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchCategory(),
      builder: (BuildContext context, _) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: _colorClass.getBackgroundColor(_noteForm['color']),
              borderRadius: BorderRadius.circular(UiBorder.rounded),
            ),
            child: WillPopScope(
              onWillPop: () => _saveNote(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgButton(
                                  icon: UniconsLine.arrow_left,
                                  callback: () => _saveNote(context),
                                ),
                              ],
                            ),
                            if (_noteForm.isNotEmpty)
                              FormInput(
                                autoFocus: false,
                                initialValue: _noteForm['title'],
                                hintText: TITLE,
                                maxLines: null,
                                onSaved: (value) =>
                                    setState(() => _noteForm['title'] = value),
                              ),
                            if (_noteForm.isNotEmpty)
                              FormInput(
                                autoFocus: false,
                                initialValue: _noteForm['note'],
                                hintText: NOTE,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onSaved: (value) =>
                                    setState(() => _noteForm['note'] = value),
                              ),
                            if (_listCategories.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child: ValueListenableBuilder<List<dynamic>>(
                                  valueListenable: currentCategories,
                                  builder: (context, selectedCategories, _) {
                                    return Wrap(
                                      runSpacing: 8,
                                      spacing: 8,
                                      children: _listCategories.map((item) {
                                        return CategoryItemWidget(
                                          callback: () =>
                                              _openCategoryModal(context),
                                          category: item,
                                          isSmall: true,
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  NoteMenu(
                    callback: (value) => setState(() => _noteForm = value),
                    note: _noteForm,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
