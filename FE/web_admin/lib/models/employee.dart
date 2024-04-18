class Employee {
  final String id;
  final String avatar;
  final String fullName;
  final String introduction;
  final String born;
  final String gender;
  final String address;
  final String phoneNumber;
  final String certification;
  final String field_id;

  @override
  String toString() {
    return '\nEmployee {id: $id, avatar: $avatar, fullName: $fullName, introduction: $introduction, born: $born, gender: $gender, address: $address, phoneNumber: $phoneNumber, certification: $certification}';
  }

  List<String> toArray() => [
        id,
        avatar,
        fullName,
        introduction,
        born,
        gender,
        address,
        phoneNumber,
        certification,
        field_id
      ];

  static List<String> toName() {
    return [
      'Id',
      'Avatar',
      'Full Name',
      'Introduction',
      'Born',
      'Gender',
      'Address',
      'Phone number',
      'Certification',
      'Field ID'
    ];
  }

  Employee(
      {required this.id,
      required this.avatar,
      required this.fullName,
      required this.introduction,
      required this.born,
      required this.gender,
      required this.address,
      required this.phoneNumber,
      required this.certification,
      required this.field_id});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'].toString(),
      avatar: json['avatar'].toString(),
      fullName: json['fullname'].toString(),
      introduction: json['introduction'].toString(),
      born: json['born'].toString(),
      gender: json['gender'].toString(),
      address: json['address'].toString(),
      phoneNumber: json['phoneNumber'].toString(),
      certification: json['certification'].toString(),
      field_id: json['field_id'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'avatar': avatar,
        'fullName': fullName,
        'introduction': introduction,
        'born': born,
        'gender': gender,
        'address': address,
        'phoneNumber': phoneNumber,
        'certification': certification,
        'field_id': field_id
      };
}
