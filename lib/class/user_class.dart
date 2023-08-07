import 'package:segura_app/model/user_model.dart';
import 'package:segura_app/service/value_notifier_service.dart';

class UserClass {
  deleteUser() {
    currentUser.value = UserModel(
      userAvatar: "",
      userId: "",
      userName: "",
      userEmail: "",
    );
  }
}
