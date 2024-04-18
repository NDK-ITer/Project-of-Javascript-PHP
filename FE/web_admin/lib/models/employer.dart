class Employer {
  final String id;
  final String companyName;
  final String logo;
  final String description;
  final String hotLine;
  final String address;

  @override
  String toString() {
    return '\nEmployer {id: $id, companyName: $companyName, logo: $logo, description: $description, hotLine: $hotLine, address: $address}';
  }

  Employer({
    required this.id,
    required this.companyName,
    required this.logo,
    required this.description,
    required this.hotLine,
    required this.address,
  });

  static List<String> toName() {
    return [
      'select',
      'Id',
      'CompanyName',
      'Logo',
      'Description',
      'HotLine',
      'Address'
    ];
  }

  List<String> toArray() =>
      ['false', id, companyName, logo, description, hotLine, address];

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Company Name': companyName,
      'Logo': logo,
      'Description': description,
      'HotLine': hotLine,
      'Address': address,
    };
  }

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      id: json['id'] ?? '',
      companyName: json['companyName'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      hotLine: json['hotline'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
