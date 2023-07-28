import 'package:flutter/material.dart';

ValueNotifier<Brightness> currentTheme = ValueNotifier(
    WidgetsBinding.instance.platformDispatcher.platformBrightness);
