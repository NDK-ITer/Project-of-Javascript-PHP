import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatjob/baseULR.dart';
import 'package:whatjob/home/home.dart';
import 'package:whatjob/model/employer.dart';
import 'package:whatjob/service/employerService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EmployerEditInfo extends StatefulWidget {
  final Employer employer;
  final String token;
  final String roleName;
  final String email;
  const EmployerEditInfo({
    super.key,
    required this.employer,
    required this.token,
    required this.roleName,
    required this.email,
  });

  @override
  _EmployerEditInfoState createState() => _EmployerEditInfoState();
}

class _EmployerEditInfoState extends State<EmployerEditInfo> {
  File? _image;
  final String _avatar =
      'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int _selectedValue = 1;

  void _selectGender(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void initState() {
    super.initState();
    _nameController.text = widget.employer.companyName;
    _addressController.text = widget.employer.address;
    _phoneController.text = widget.employer.hotLine;
    _descriptionController.text = widget.employer.description;
  }

  @override
  Widget build(BuildContext context) {
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
                        image: NetworkImage(widget.employer.logo),
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
                        hintText: "Name",
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
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: "Hotline",
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
                        hintText: "Address",
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
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 6 * 20.0,
                        ),
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Introduce',
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
                    onPressed: () async {
                      Map<String, dynamic> newData = {
                        'companyName': _nameController.text,
                        'logo': _image == null ? widget.employer.logo : await uploadImageToFirebaseStorage(_image!),
                        'description': _descriptionController.text,
                        'hotLine': _phoneController.text,
                        'address': _addressController.text,
                      };
                      final response = await EmployerService.updateInfo(
                          widget.token, newData);
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
                      }
                    },
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

  //====================================

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
}
