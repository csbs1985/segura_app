import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserHive {
  final _userBox = Hive.box('user');

  Future<void> saveUser(Map<String, dynamic> user) async {
    await _userBox.add(user);
  }

  Future<void> deleteUser() async {
    await _userBox.clear();
  }

  Future<Map<dynamic, dynamic>?> getUser() async {
    return _userBox.values.first;
  }

  Future<bool> doesUserExist() async {
    return _userBox.isNotEmpty;
  }
}
