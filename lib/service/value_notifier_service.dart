import 'package:flutter/material.dart';
import 'package:segura_app/model/user_model.dart';

ValueNotifier<Brightness> currentTheme = ValueNotifier(Brightness.light);

ValueNotifier<UserModel> currentUser = ValueNotifier(UserModel(
  userAvatar: "",
  userId: "",
  userName: "",
  userEmail: "",
));
