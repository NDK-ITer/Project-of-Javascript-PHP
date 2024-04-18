class RADetail {
  final String id;
  final String name;
  final String image;
  final DateTime dateUpload;
  final String position;
  final int countEmployee;
  final String ageEmployee;
  final String degree;
  final int yearOfExperience;
  final String formOfWork;
  final String fieldName;
  final String salary;
  final DateTime endSubmission;
  final String addressWork;
  final String description;

  RADetail({
    required this.id,
    required this.name,
    required this.image,
    required this.dateUpload,
    required this.position,
    required this.countEmployee,
    required this.ageEmployee,
    required this.degree,
    required this.yearOfExperience,
    required this.formOfWork,
    required this.fieldName,
    required this.salary,
    required this.endSubmission,
    required this.addressWork,
    required this.description,
  });

  RADetail.empty()
    : id = '',
      name = '',
      image = '',
      dateUpload = DateTime.now(),
      position = '',
      countEmployee = 0,
      ageEmployee = '',
      degree = '',
      yearOfExperience = 0,
      formOfWork = '',
      fieldName = '',
      salary = '',
      endSubmission = DateTime.now(),
      addressWork = '',
      description = '';

  factory RADetail.fromJson(Map<String, dynamic> json) {
    return RADetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      dateUpload: DateTime.parse(json['dateUpload']),
      position: json['position'],
      countEmployee: int.parse(json['countEmployee']),
      ageEmployee: json['ageEmployee'],
      degree: json['degree'],
      yearOfExperience: int.parse(json['yearOfExpensive']),
      formOfWork: json['formOfWork'],
      fieldName: json['fieldName'],
      salary: json['salary'].toString(),
      endSubmission: DateTime.parse(json['endSubmission']),
      addressWork: json['addressWork'],
      description: json['description'],
    );
  }
}