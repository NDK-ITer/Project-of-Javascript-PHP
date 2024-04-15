class User {
  final String id;
  final String email;
  final String role;
  final String password;
  final String isBlock;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.isBlock,
    required this.password,
  });

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     displayName: json['email'],
  //     avatar: json['avatar'],
  //     roleId: json['roleId'],
  //   );
  // }
}
