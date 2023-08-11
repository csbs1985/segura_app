import "package:flutter/material.dart";
import "package:segura_app/service/value_notifier_service.dart";
import "package:segura_app/theme/ui_color.dart";

class ColorClass {
  final List<Map<String, dynamic>> listColors = [
    {"value": 0, "color": UiColor.color0, "dark": UiColor.color0Dark},
    {"value": 1, "color": UiColor.color1, "dark": UiColor.color1Dark},
    {"value": 2, "color": UiColor.color2, "dark": UiColor.color2Dark},
    {"value": 3, "color": UiColor.color3, "dark": UiColor.color3Dark},
    {"value": 4, "color": UiColor.color4, "dark": UiColor.color4Dark},
    {"value": 5, "color": UiColor.color5, "dark": UiColor.color5Dark},
    {"value": 6, "color": UiColor.color6, "dark": UiColor.color6Dark},
    {"value": 7, "color": UiColor.color7, "dark": UiColor.color7Dark},
    {"value": 8, "color": UiColor.color8, "dark": UiColor.color8Dark},
    {"value": 9, "color": UiColor.color9, "dark": UiColor.color9Dark},
    {"value": 10, "color": UiColor.color10, "dark": UiColor.color10Dark},
    {"value": 11, "color": UiColor.color11, "dark": UiColor.color11Dark},
  ];

  Color getColor(int value) {
    bool isDark = currentTheme.value == Brightness.dark ? true : false;

    for (var colorEntry in listColors) {
      if (colorEntry["value"] == value) {
        return isDark ? colorEntry["dark"] : colorEntry["color"];
      }
    }
    return UiColor.color0;
  }

  Color getBackgroundColor(int value) {
    bool isDark = currentTheme.value == Brightness.dark ? true : false;
    return isDark ? listColors[value]["dark"] : listColors[value]["color"];
  }
}
