class User {
  String id;
  String email;
  String role;
  String password;
  String isBlock;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.isBlock,
    required this.password,
  });

  @override
  String toString() =>
      '\nUser { id: $id, email: $email, role: $role, isBlock: $isBlock, password: $password} ';

  static List<String> toName() {
    return ['select', 'Id', 'Email', 'Role', 'Password', 'IsBlock'];
  }

  List<String> toArray() => ['false', id!, email, role, password, isBlock];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'].toString(),
      role: json['role'].toString(),
      password: json['password'].toString(),
      isBlock: json['isBlock'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'password': password,
      'isBlock': isBlock,
    };
  }
}
