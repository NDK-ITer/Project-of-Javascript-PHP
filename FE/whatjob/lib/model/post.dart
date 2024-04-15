class PostClass {
  final String id;
  final String companyName;
  final String companyLogo;
  final String name;
  final String description;
  final String salary;
  final String image;

  PostClass({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.name,
    required this.description,
    required this.salary,
    required this.image,
  });

  PostClass.empty()
      : id = '',
        companyName = '',
        companyLogo = '',
        name = '',
        description = '',
        salary = '',
        image = '';

  factory PostClass.fromJson(Map<String, dynamic> json) {
    return PostClass(
      id: json['id'] ?? '',
      companyName: json['companyName'] ?? '',
      companyLogo: json['companyLogo'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      salary: json['salary'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
