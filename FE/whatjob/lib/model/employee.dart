class Employee {
  final String avatar;
  final String fullName;
  final String introduction;
  final DateTime born;
  final String gender;
  final String address;
  final String phoneNumber;
  final String certification;
  final String cv;


  Employee({
    required this.avatar,
    required this.fullName,
    required this.introduction,
    required this.born,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.certification,
    required this.cv,
  });

  Employee.empty()
      : avatar = '',
        fullName = '',
        introduction = '',
        born = DateTime.now(),
        gender = '',
        address = '',
        phoneNumber = '',
        certification = '',
        cv = '';

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      avatar: json['avatar'] ?? '',
      fullName: json['fullName'] ?? json['fullname'] ?? '',
      introduction: json['introduction'] ?? '',
      born: DateTime.parse(json['born']),
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? json['phonenumber'] ?? '',
      certification: json['certification'] ?? '',
      cv: json['cv'] ?? '',
    );
  }

  @override
  String toString() {
    return '\nEmployee{'
        'avatar: $avatar, '
        'fullName: $fullName, '
        'introduction: $introduction, '
        'born: $born, '
        'gender: $gender, '
        'address: $address, '
        'phoneNumber: $phoneNumber, '
        'certification: $certification, '
        'cv: $cv}';
  }
}
