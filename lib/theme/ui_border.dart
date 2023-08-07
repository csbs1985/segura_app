import 'package:flutter/material.dart';

class UiBorder {
  static const double circle = 400;
  static const double rounded = 12;

  static OutlineInputBorder borderCircle = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(circle),
  );

  static OutlineInputBorder borderSquared = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(rounded),
  );

  static OutlineInputBorder borderModal = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(rounded),
      topRight: Radius.circular(rounded),
    ),
  );
}
