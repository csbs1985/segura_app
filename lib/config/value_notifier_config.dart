import 'package:flutter/material.dart';
import 'package:senha_app/model/usuario_model.dart';

ValueNotifier<UsuarioModel> currentUsuario = ValueNotifier<UsuarioModel>(
  UsuarioModel(
    avatarUsuario: '',
    biometria: '',
    categorias: [],
    emailUsuario: '',
    idUsuario: '',
    nomeUsuario: '',
    senha: '',
  ),
);

ValueNotifier<Brightness> currentTema = ValueNotifier(
    WidgetsBinding.instance.platformDispatcher.platformBrightness);
