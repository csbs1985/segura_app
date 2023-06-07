import 'package:flutter/material.dart';
import 'package:senha_app/model/usuario_model.dart';

ValueNotifier<UsuarioModel> currentUsuario =
    ValueNotifier<UsuarioModel>(UsuarioModel(
  avatarUsuario: '',
  emailUsuario: '',
  idUsuario: '',
  nomeUsuario: '',
));

class UsuarioClass {}
