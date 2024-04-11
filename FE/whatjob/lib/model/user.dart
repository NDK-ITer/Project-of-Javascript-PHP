class User {
  final String displayName;
  final String avatar;

  User({required this.displayName, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['displayName'],
      avatar: json['avatar'],
    );
  }
}