import 'package:flutter/material.dart';
import 'package:senha_app/model/usuario_model.dart';

ValueNotifier<UsuarioModel> currentUsuario = ValueNotifier<UsuarioModel>(
  UsuarioModel(
    avatarUsuario: '',
    biometria: false,
    emailUsuario: '',
    idUsuario: '',
    nomeUsuario: '',
  ),
);

ValueNotifier<Map<String, dynamic>> currentSenha =
    ValueNotifier<Map<String, dynamic>>({});

ValueNotifier<Brightness> currentTema = ValueNotifier(
    WidgetsBinding.instance.platformDispatcher.platformBrightness);

final ValueNotifier<bool> currentIsLocalAuthFailed = ValueNotifier(false);

final ValueNotifier<List<Map<String, dynamic>>> currentCategorias =
    ValueNotifier<List<Map<String, dynamic>>>([]);

final ValueNotifier<bool> currentLayout = ValueNotifier<bool>(false);
