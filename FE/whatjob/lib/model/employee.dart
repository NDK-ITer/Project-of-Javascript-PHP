class Employee {
  final String avatar;
  final String fullName;
  final String introduction;
  final DateTime born;
  final String gender;
  final String address;
  final String phoneNumber;
  final String certification;

  Employee({
    required this.avatar,
    required this.fullName,
    required this.introduction,
    required this.born,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.certification,
  });

  Employee.empty()
      : avatar = '',
        fullName = '',
        introduction = '',
        born = DateTime.now(),
        gender = '',
        address = '',
        phoneNumber = '',
        certification = '';

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      avatar: json['avatar'] ?? '',
      fullName: json['fullName'] ?? '',
      introduction: json['introduction'] ?? '',
      born: DateTime.parse(json['born']),
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      certification: json['certification'] ?? '',
    );
  }
}
