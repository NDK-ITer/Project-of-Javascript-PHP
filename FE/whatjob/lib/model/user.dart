class User {
  final String displayName;
  final String avatar;
  final String roleId;

  User({required this.displayName, required this.avatar, required this.roleId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['displayName'] ?? json['companyName'] ?? json['fullname'] ?? '',
      avatar: json['avatar'] ?? json['logo'],
      roleId: json['roleId'] ??  json['role'],
    );
  }
}