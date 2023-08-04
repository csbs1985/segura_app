import 'package:flutter/material.dart';
import 'package:segura_app/model/note_modal.dart';
import 'package:segura_app/model/user_model.dart';

ValueNotifier<NoteModal> currentNote = ValueNotifier(NoteModal(
  category: [],
  dateRegistration: "",
  excluded: false,
  note: "",
  noteId: "",
  position: 0,
  shared: [],
  title: "",
  userId: "",
));

ValueNotifier<String> currentNoteId = ValueNotifier("");

ValueNotifier<Brightness> currentTheme = ValueNotifier(Brightness.light);

ValueNotifier<UserModel> currentUser = ValueNotifier(UserModel(
  userAvatar: "",
  userId: "",
  userName: "",
  userEmail: "",
));
