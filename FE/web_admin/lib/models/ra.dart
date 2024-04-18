class Ra {
  final String? id;
  final String? name;
  final String? requirement;
  final String? description;
  final String? image;
  final String? salary;
  final String? addressWork;
  final String? isApproved;
  final String? endSubmission;
  final String? ageEmployee;
  final String? countEmployee;
  final String? formOfWork;
  final String? yearsOfExperience;
  final String? degree;
  final String? position;
  final String? employerId;
  final String? fieldId;
  final String? fieldName;

  static List<String> toName() {
    return [
      'Id',
      'Name',
      'Requirement',
      'Description',
      'Image',
      'Salary',
      'Work Address',
      'Approved',
      'End Submission Date',
      'Age',
      'Quantity',
      'Work Form',
      'Years of Experience',
      'Degree',
      'Position',
      'Employer Id',
      'Field Id',
      'Field Name'
    ];
  }

  @override
  String toString() {
    return '\nRa {id: $id, name: $name, requirement: $requirement, description: $description, image: $image, salary: $salary, addressWork: $addressWork, isApproved: $isApproved, endSubmission: $endSubmission, ageEmployee: $ageEmployee, countEmployee: $countEmployee, formOfWork: $formOfWork, yearsOfExperience: $yearsOfExperience, degree: $degree, position: $position , employerId: $employerId, fieldId: $fieldId, fieldName: $fieldName}';
  }

  List<String> toArray() {
    return [
      id!,
      name!,
      requirement!,
      description!,
      image!,
      salary!,
      addressWork!,
      isApproved!,
      endSubmission!,
      ageEmployee!,
      countEmployee!,
      formOfWork!,
      yearsOfExperience!,
      degree!,
      position!,
      employerId!,
      fieldId!,
      fieldName!
    ];
  }

  Ra({
    required this.id,
    required this.name,
    required this.requirement,
    required this.description,
    required this.image,
    required this.salary,
    required this.addressWork,
    required this.isApproved,
    required this.endSubmission,
    required this.ageEmployee,
    required this.countEmployee,
    required this.formOfWork,
    required this.yearsOfExperience,
    required this.degree,
    required this.position,
    required this.employerId,
    required this.fieldId,
    required this.fieldName,
  });

  factory Ra.fromJson(Map<String, dynamic> json) {
    return Ra(
      id: json['id'],
      name: json['name'],
      requirement: json['requirement'],
      description: json['description'],
      image: json['image'],
      salary: json['salary'],
      addressWork: json['addressWork'],
      isApproved: json['isApproved'],
      endSubmission: json['endSubmission'],
      ageEmployee: json['ageEmployee'],
      countEmployee: json['countEmployee'],
      formOfWork: json['formOfWork'],
      yearsOfExperience: json['yearsOfExperience'],
      degree: json['degree'],
      position: json['position'],
      employerId: json['employer_id'],
      fieldId: json['field']['id'],
      fieldName: json['field']['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'requirement': requirement,
        'description': description,
        'image': image,
        'salary': salary,
        'addressWork': addressWork,
        'isApproved': isApproved,
        'endSubmission': endSubmission,
        'ageEmployee': ageEmployee,
        'countEmployee': countEmployee,
        'formOfWork': formOfWork,
        'yearOfExpensive': yearsOfExperience,
        'degree': degree,
        'employer_id': employerId,
        'field_id': fieldId,
        'position': position,
        'dateUpload': DateTime.now(),
      };
}
