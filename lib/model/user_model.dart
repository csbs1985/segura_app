class UserModel {
  final String avatar;
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.avatar,
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
