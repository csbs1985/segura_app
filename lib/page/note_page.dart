import 'package:go_router/go_router.dart';
import 'package:segura_app/button/svg_button.dart';
import 'package:segura_app/class/note_class.dart';
import 'package:segura_app/widget/form_input.dart';
import 'package:segura_app/widget/note_bottom_sheet.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:segura_app/firestore/notes.firestore.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required String noteId,
  }) : _noteId = noteId;

  final String _noteId;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NoteClass _noteClass = NoteClass();
  final NoteFirestore _noteFirestore = NoteFirestore();
  final Uuid uuid = const Uuid();

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerNote = TextEditingController();

  final List<dynamic> _category = [];
  final List<dynamic> _shared = [];
//   final List<Map<String, dynamic>> _listaCategorias = [];

  Map<String, dynamic> _noteForm = {};

  String noteCurrent = "";
  String titleCurrent = "";

  @override
  void initState() {
    initNote();
    super.initState();
  }

  initNote() async {
    if (widget._noteId != EMPTY) {
      Map<String, dynamic> itemCurrent = {};
      await _noteFirestore.getNoteId(widget._noteId).then((document) => {
            itemCurrent = document.data() as Map<String, dynamic>,
            _noteForm = {
              "category": itemCurrent['category'],
              "dateRegistration": itemCurrent['dateRegistration'],
              "excluded": itemCurrent['excluded'],
              "noteId": widget._noteId,
              "note": itemCurrent['note'],
              "shared": itemCurrent['shared'],
              "title": itemCurrent['title'],
              "userId": itemCurrent['userId'],
            },
            _setControllers(),
            _setCategories(itemCurrent['category']),
          });
    }
  }

  _setControllers() {
    _controllerNote.text = _noteForm['note'];
    _controllerTitle.text = _noteForm['title'];
  }

  _setCategories(List<dynamic> categorias) {
    // Map<String, dynamic>? categoria;

    // for (var item in categorias) {
    //   _categoriaFirestore.receberCategoriaId(item).then((result) => {
    //         categoria = result.data() as Map<String, dynamic>,
    //         setState(() => _listaCategorias.add(categoria!)),
    //       });
    // }

    // currentCategorias.value = _listaCategorias;
  }

//   void _abrirCategoriaModal() {
//     // showCupertinoModalBottomSheet(
//     //   expand: true,
//     //   context: context,
//     //   barrierColor: UiCor.overlay,
//     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     //   builder: (context) => const CategoriaModal(),
//     // );
//   }

  saveNote(BuildContext context) async {
    if ((_noteForm['note'] == "" ||
            _noteForm['note'] == null ||
            noteCurrent == _noteForm['note']) &&
        (_noteForm['title'] == "" ||
            _noteForm['title'] == null ||
            titleCurrent == _noteForm['title'])) {
      context.pop();
    } else {
      setState(() {
        if (widget._noteId != EMPTY) {
          // editar
          _noteForm = {
            "category": _category,
            "dateRegistration": DateTime.now().toString(),
            "excluded": _noteForm['excluded'],
            "noteId": _noteForm['noteId'],
            "note": _controllerNote.text,
            "shared": _shared,
            "title": _controllerTitle.text,
            "userId": currentUser.value.userId,
          };
        } else {
          // criar
          _noteForm = {
            "category": _category,
            "dateRegistration": DateTime.now().toString(),
            "excluded": false,
            "noteId": uuid.v4(),
            "note": _controllerNote.text,
            "shared": _shared,
            "title": _controllerTitle.text,
            "userId": currentUser.value.userId,
          };
        }
      });

      _noteClass.saveNote(context, _noteForm);
    }
  }

  @override
  void dispose() {
    _controllerNote.dispose();
    _controllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: SvgButton(
          icon: UniconsLine.arrow_left,
          callback: () => saveNote(context),
        ),
      ),
      bottomSheet: NoteBottomSheet(
        callback: (value) => setState(() => {}),
        note: _noteForm,
      ),
      body: WillPopScope(
        onWillPop: () => saveNote(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormInput(
                controller: _controllerTitle,
                callback: (value) => setState(() => _noteForm['title'] = value),
                hintText: TITLE,
              ),
              FormInput(
                controller: _controllerNote,
                callback: (value) => setState(() => _noteForm['note'] = value),
                hintText: NOTE,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
