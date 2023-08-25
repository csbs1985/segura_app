import 'package:flutter/material.dart';
import 'package:segura_app/model/note_model.dart';
import 'package:segura_app/model/user_model.dart';

ValueNotifier<List<dynamic>> currentCategories =
    ValueNotifier<List<dynamic>>([]);

ValueNotifier<NoteModel> currentNote = ValueNotifier(NoteModel(
  category: [],
  color: 0,
  dateRegistration: "",
  excluded: false,
  note: "",
  noteId: "",
  position: 0,
  shared: [],
  title: "",
  userId: "",
));

ValueNotifier<Brightness> currentTheme = ValueNotifier(Brightness.light);

ValueNotifier<UserModel> currentUser = ValueNotifier(UserModel(
  userAvatar: "",
  userId: "",
  userName: "",
  userEmail: "",
));
