class Role {
  final String id;
  final String name;
  final String normalizeName;

  @override
  String toString() =>
      '\nRole { id: $id, name: $name, normalizeName: $normalizeName} ';

  static List<String> toName() {
    return ['select', 'id', 'name', 'normalizeName'];
  }

  List<String> toArray() => ['false', id, name, normalizeName];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'normalizeName': normalizeName,
      };

  Role({
    required this.id,
    required this.name,
    required this.normalizeName,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      normalizeName: json['normalizeName'],
    );
  }

  // factory Role.fromArray(List<Role> list) {
  //   return List<String>.from(list.map((e) => e.name));
  // }
}
