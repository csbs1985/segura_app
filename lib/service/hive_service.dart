import 'package:hive_flutter/adapters.dart';

class HiveService {
  static start() async {
    await Hive.initFlutter();
    await Hive.openBox('user');
    await Hive.openBox('recent');
  }
}
