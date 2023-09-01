import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecentHive {
  final _recentBox = Hive.box('recent');

  Future<void> saveRecent(Map<dynamic, dynamic> recent) async {
    await _recentBox.add(recent);
  }

  Future<Map<dynamic, dynamic>?> getRecent() async {
    return await _recentBox.values.first;
  }

  Future<bool> doesRecentExist() async {
    return _recentBox.isNotEmpty;
  }
}
