import 'package:segura_app/appbar/note_appbar.dart';
import 'package:segura_app/widget/note_bottom_sheet.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:segura_app/firestore/notes.firestore.dart';
import 'package:segura_app/service/text_service.dart';
import 'package:segura_app/service/value_notifier_service.dart';
import 'package:segura_app/widget/form_input.dart';

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
  final NoteFirestore _noteFirestore = NoteFirestore();
  final Uuid uuid = const Uuid();

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerNote = TextEditingController();

  final List<dynamic> _category = [];
  final List<dynamic> _shared = [];
//   final List<Map<String, dynamic>> _listaCategorias = [];

  Map<String, dynamic> _noteForm = {};

  @override
  void initState() {
    initNote();
    super.initState();
  }

  initNote() async {
    if (widget._noteId != EMPTY) {
      Map<String, dynamic> noteCurrent = {};
      await _noteFirestore.getNoteId(widget._noteId).then((document) => {
            noteCurrent = document.data() as Map<String, dynamic>,
            _noteForm = {
              "category": noteCurrent['category'],
              "note": noteCurrent['note'],
              "shared": noteCurrent['shared'],
              "title": noteCurrent['title'],
            },
            _setControllers(),
            _setCategories(noteCurrent['category']),
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

  floatingActionButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (widget._noteId != EMPTY) {
          // editar
          _noteForm = {
            "category": _category,
            "dateRegistration": DateTime.now().toString(),
            "excluded": _noteForm['excluded'],
            "noteId": _noteForm['noteId'],
            "userId": currentUser.value.userId,
            "note": _controllerNote.text,
            "shared": _shared,
            "title": _controllerTitle.text
          };
        } else {
          // criar
          _noteForm = {
            "category": _category,
            "dateRegistration": DateTime.now().toString(),
            "excluded": false,
            "noteId": uuid.v4(),
            "userId": currentUser.value.userId,
            "note": _controllerNote.text,
            "shared": _shared,
            "title": _controllerTitle.text
          };
        }
      });

      // _senhaClass.salvarSenha(context, _noteForm);
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
      appBar: NoteAppBar(
        callback: (value) => setState(() => {}),
        note: _noteForm,
      ),
      bottomNavigationBar: NoteBottomSheet(
        callback: (value) => setState(() => {}),
        note: _noteForm,
      ),
      body: WillPopScope(
        onWillPop: () {
          return floatingActionButton(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              FormInput(
                controller: _controllerTitle,
                callback: (value) => setState(() => _noteForm['title'] = value),
                hintText: TITLE,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              FormInput(
                controller: _controllerNote,
                callback: (value) => setState(() => _noteForm['note'] = value),
                hintText: NOTA,
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
