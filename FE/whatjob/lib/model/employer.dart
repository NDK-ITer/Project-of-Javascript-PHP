class Employer {
  final String companyName;
  final String logo;
  final String description;
  final String hotLine;
  final String address;

  Employer({
    required this.companyName,
    required this.logo,
    required this.description,
    required this.hotLine,
    required this.address,
  });

  Employer.empty()
      : companyName = '',
        logo = '',
        description = '',
        hotLine = '',
        address = '';

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      companyName: json['companyName'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      hotLine: json['hotLine'] ?? '',
      address: json['address'] ?? '',
    );
  }

  @override
  String toString() {
    return '\nEmployer{'
        'companyName: $companyName, '
        'logo: $logo, '
        'description: $description, '
        'hotLine: $hotLine, '
        'address: $address'
        '}';
  }
}