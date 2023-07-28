import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:segura_app/model/user_model.dart';

class UserHive {
  final _userBox = Hive.box('user');

  Future<void> saveUser(Map<String, dynamic> user) async {
    await _userBox.add(user);
  }

  Future<void> deleteUser() async {
    await _userBox.clear();
  }

  Future<UserModel?> getUser() async {
    return _userBox.get('user');
  }

  Future<bool> doesUserExist() async {
    return _userBox.isNotEmpty;
  }
}
