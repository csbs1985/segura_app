class UserModel {
  final String userAvatar;
  final String userId;
  final String userName;
  final String userEmail;

  UserModel({
    required this.userAvatar,
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'userAvatar': userAvatar,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }
}
