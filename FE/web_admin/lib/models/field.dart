class Field {
  final String id;
  final String name;

  Field({required this.id, required this.name});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'],
      name: json['name'],
    );
  }
}