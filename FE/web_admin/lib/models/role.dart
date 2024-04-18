class Role {
   String? id;
    String name;
   String? normalizeName;

  @override
  String toString() =>
      '\nRole { id: $id, name: $name, normalizeName: $normalizeName} ';

  static List<String> toName() {
    return ['select', 'Id', 'Name', 'NormalizeName'];
  }

  List<String> toArray() => ['false', id!, name, normalizeName!];

  Map<String, dynamic> toJson() => {
    "id": id,
        "name": name,
    "normalizeName": normalizeName
      };

  Role({
    this.id,
    required this.name,
    this.normalizeName,
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
