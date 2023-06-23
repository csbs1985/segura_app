import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LayoutHive {
  final _layoutBox = Hive.box('layout');

  salvarLayout(bool _layout) async {
    await _layoutBox.add(_layout);
  }

  receberLayout() {
    return _layoutBox.values.first;
  }
}
