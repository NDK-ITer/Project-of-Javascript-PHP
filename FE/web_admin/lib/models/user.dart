class User {
  String _id;
  String email;
  String role;
  String password;
  String isBlock;

  User(
    this._id, {
    required this.email,
    required this.role,
    required this.password,
    required this.isBlock,
  });

  @override
  String toString() =>
      '\nUser { id: $id, email: $email, role: $role, isBlock: $isBlock, password: $password} ';

  static List<String> toName() {
    return ['select', 'Id', 'Email', 'Role', 'Password', 'IsBlock'];
  }

  List<String> toArray() => ['false', id, email, role, password, isBlock];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'].toString(),
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

  // Getter để truy cập vào giá trị id
  String get id => _id;

  // Setter để cập nhật giá trị id
  set id(String value) {
    _id = value;
  }
}
