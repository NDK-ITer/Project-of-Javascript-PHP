class Field {
  String id;
  String name;

  Field({required this.id, required this.name});

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  @override
  String toString() {
    return '\nField {id: $id, name: $name}';
  }

  static List<String> toName() {
    return ['select', 'Id', 'Name'];
  }

  List<String> toArray() => ['false', id, name];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
