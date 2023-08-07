import 'package:flutter/material.dart';
import 'package:segura_app/model/note_modal.dart';
import 'package:segura_app/model/user_model.dart';

ValueNotifier<NoteModel> currentNote = ValueNotifier(NoteModel(
  category: [],
  dateRegistration: "",
  excluded: false,
  note: "",
  noteId: "",
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
