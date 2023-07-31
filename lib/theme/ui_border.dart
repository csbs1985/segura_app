import 'package:flutter/material.dart';

class UiBorder {
  static const double circle = 400;
  static const double rounded = 12;

  static OutlineInputBorder borderCircle = const OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(circle),
      topRight: Radius.circular(circle),
      bottomRight: Radius.circular(circle),
      bottomLeft: Radius.circular(circle),
    ),
  );

  static OutlineInputBorder borderSquared = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(rounded),
  );
}
