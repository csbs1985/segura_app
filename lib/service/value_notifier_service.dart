import 'package:flutter/material.dart';
import 'package:segura_app/model/note_modal.dart';
import 'package:segura_app/model/user_model.dart';

ValueNotifier<NoteModal> currentNote = ValueNotifier(NoteModal(
  category: [],
  dateRegistration: "",
  excluded: false,
  noteId: "",
  userId: "",
  note: "",
  shared: [],
  title: "",
));

ValueNotifier<Brightness> currentTheme = ValueNotifier(Brightness.light);

ValueNotifier<UserModel> currentUser = ValueNotifier(UserModel(
  userAvatar: "",
  userId: "",
  userName: "",
  userEmail: "",
));
