import 'package:flutter/material.dart';
import 'package:senha_app/model/usuario_model.dart';

ValueNotifier<UsuarioModel> currentUsuario = ValueNotifier<UsuarioModel>(
  UsuarioModel(
    avatarUsuario: '',
    biometria: false,
    categorias: [],
    emailUsuario: '',
    idUsuario: '',
    nomeUsuario: '',
  ),
);

ValueNotifier<Brightness> currentTema = ValueNotifier(
    WidgetsBinding.instance.platformDispatcher.platformBrightness);

final ValueNotifier<bool> currentIsLocalAuthFailed = ValueNotifier(false);
