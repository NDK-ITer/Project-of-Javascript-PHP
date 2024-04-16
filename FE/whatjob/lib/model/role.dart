class Role {
  final String id;
  final String name;
  final String normalizeName;

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
}