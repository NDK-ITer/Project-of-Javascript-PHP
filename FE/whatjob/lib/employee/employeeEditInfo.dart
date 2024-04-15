import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatjob/home/home.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/service/employeeService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EmployeeEditInfo extends StatefulWidget {
  final Employee employee;
  final String email;
  final String token;
  final String roleName;

  const EmployeeEditInfo({
    super.key,
    required this.employee,
    required this.email,
    required this.token,
    required this.roleName,
  });

  @override
  _EmployeeEditInfoState createState() => _EmployeeEditInfoState();
}

class _EmployeeEditInfoState extends State<EmployeeEditInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();
  int _selectedValue = 0;
  File? _image;

  String _selectedField = 'IT';

  late DateTime selectedDate = widget.employee.born;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _birthdayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> deleteImageFromFirebaseStorage(String imageURL) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference imageRef = storage.refFromURL(imageURL);

    try {
      await imageRef.delete();
    } catch (e) {
      print('Lỗi khi xóa hình ảnh từ Firebase Storage: $e');
    }
  }

  String getFileNameFromPath(String path) {
    return path.split('/').last;
  }

  Future<String> uploadImageToFirebaseStorage(File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
        storage.ref().child('Avatar/${getFileNameFromPath(file.path)}');
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> onPressedChooseAva() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String gender(int value) {
    return value == 1 ? "Male" : "Female";
  }

  void editEmployee() async {
    try {
      Map<String, dynamic> newData = {
        "avatar": _image == null
            ? widget.employee.avatar
            : await uploadImageToFirebaseStorage(_image!),
        "fullName": _nameController.text,
        "introduction": _introduceController.text,
        "born": _birthdayController.text,
        "gender": gender(_selectedValue),
        "address": _addressController.text,
        "phoneNumber": _phoneController.text,
        "certification": "",
      };

      print(newData.toString());
      final response = await EmployeeService.edit(widget.token, newData);
      final responseData = json.decode(response.body);
      final int state = responseData['state'];
      if (state == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    token: widget.token,
                    email: widget.email,
                    roleName: widget.roleName,
                  )),
        );
        if(_image != null) {deleteImageFromFirebaseStorage(widget.employee.avatar);};
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();

    // Assign values from widget.employee to controllers
    _nameController.text = widget.employee.fullName;
    _birthdayController.text =
        DateFormat('dd/MM/yyyy').format(widget.employee.born);
    _addressController.text = widget.employee.address;
    _phoneController.text = widget.employee.phoneNumber;
    _emailController.text = widget.email;
    _introduceController.text = widget.employee.introduction ?? 'Introduce';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.employee.gender == "Male") {
      _selectedValue = 1;
    } else {
      _selectedValue = 2;
    }

    void _selectGender(int value) {
      setState(() {
        _selectedValue = value;
      });
    }

    return Scaffold(
      backgroundColor: AppColors.yellow,
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        iconTheme: const IconThemeData(color: AppColors.green),
        title: const Text(
          'Chỉnh sửa thông tin',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 18,
            color: AppColors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: _image != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(_image!),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.employee.avatar),
                      ),
              ),
            ),
          ),
          TextButton(
              onPressed: onPressedChooseAva,
              child: const Text(
                "Chọn",
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.green),
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green, // Màu của viền
                        width: 2.0,
                      ),
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Họ và tên",
                        border: InputBorder.none,
                      ),
                      cursorColor: AppColors.green,
                      style: const TextStyle(
                          color: AppColors.green,
                          fontSize: 15,
                          fontFamily: "Comfortaa"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedValue = 1;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: Radio(
                                value: 1,
                                groupValue: _selectedValue,
                                activeColor: AppColors.green,
                                onChanged: (value) => _selectGender(value!),
                              ),
                            ),
                            const Text(
                              "Nam",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedValue = 2;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: Radio(
                                value: 2,
                                groupValue: _selectedValue,
                                activeColor: AppColors.green,
                                onChanged: (value) => _selectGender(value!),
                              ),
                            ),
                            const Text(
                              "Nữ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green, // Màu của viền
                        width: 2.0,
                      ),
                    ),
                    child: TextField(
                      controller: _birthdayController,
                      decoration: InputDecoration(
                        hintText: "Ngày sinh",
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          color: AppColors.gray,
                          fontSize: 15,
                          fontFamily: "Comfortaa",
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: const Icon(
                            Icons.calendar_today,
                            color: AppColors.green,
                          ),
                        ),
                      ),
                      readOnly: true,
                      style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 15,
                        fontFamily: "Comfortaa",
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green, // Màu của viền
                        width: 2.0,
                      ),
                    ),
                    child: TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: "Số điện thoại",
                        border: InputBorder.none,
                      ),
                      cursorColor: AppColors.green,
                      style: const TextStyle(
                          color: AppColors.green,
                          fontSize: 15,
                          fontFamily: "Comfortaa"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green, // Màu của viền
                        width: 2.0,
                      ),
                    ),
                    child: TextField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        hintText: "Địa chỉ",
                        border: InputBorder.none,
                      ),
                      cursorColor: AppColors.green,
                      style: const TextStyle(
                          color: AppColors.green,
                          fontSize: 15,
                          fontFamily: "Comfortaa"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green, // Màu của viền
                        width: 2.0,
                      ),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                      cursorColor: AppColors.green,
                      style: const TextStyle(
                          color: AppColors.green,
                          fontSize: 15,
                          fontFamily: "Comfortaa"),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.green,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: DropdownButton<String>(
                  //     value: _selectedField,
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         _selectedField = newValue!;
                  //       });
                  //     },
                  //     underline: Container(
                  //       width: MediaQuery.of(context).size.width,
                  //     ),
                  //     style: const TextStyle(
                  //         color: Colors.white, fontFamily: "Comfortaa"),
                  //     dropdownColor: Colors.black,
                  //     icon: const Icon(Icons.arrow_drop_down,
                  //         color: Colors.white),
                  //     items: <String>['Marketing', 'IT', 'Law']
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: SizedBox(
                  //           width: MediaQuery.of(context).size.width - 125,
                  //           child: Text(
                  //             value,
                  //             style: const TextStyle(
                  //                 fontSize: 16.0, fontFamily: "Comfortaa"),
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green, // Màu của viền
                        width: 2.0,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 6 * 20.0,
                        ),
                        child: TextField(
                          controller: _introduceController,
                          decoration: const InputDecoration(
                            hintText: "Giới thiệu",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          cursorColor: AppColors.green,
                          style: const TextStyle(
                              color: AppColors.green,
                              fontSize: 15,
                              fontFamily: "Comfortaa"),
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => editEmployee(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: AppColors.green,
                    ),
                    child: const Text(
                      "Lưu",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Comfortaa',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
