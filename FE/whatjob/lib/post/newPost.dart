import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatjob/employer/employerHomeInfo.dart';
import 'package:whatjob/home/home.dart';
import 'package:whatjob/model/field.dart';
import 'package:whatjob/service/feildService.dart';
import 'package:whatjob/service/raService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:intl/intl.dart';

class NewPost extends StatefulWidget {
  final String compnayName;
  final String companyImage;
  final String email;
  final String token;
  final String roleName;

  const NewPost({
    super.key,
    required this.compnayName,
    required this.companyImage,
    required this.email,
    required this.token,
    required this.roleName,
  });

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File? _image;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _endSubmissionController =
      TextEditingController();
  final TextEditingController _workAddressController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _countEmployeeController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _feildController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _formOfWorkController = TextEditingController();

  late DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _endSubmissionController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(picked);
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

  @override
  void initState() {
    super.initState();
    _fetchFields();
  }

  List<Field> fields = [];
  late Field selectedField = Field(id: '', name: '');

  Future<void> _fetchFields() async {
    final fieldsJson = await FieldService.fetchFields();
    fields = fieldsJson.map((fieldJson) => Field.fromJson(fieldJson)).toList();
    setState(() {
      selectedField = fields.isNotEmpty ? fields[0] : Field(id: '', name: '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployerHomeInfo(
                                        token: widget.token,
                                        email: widget.email,
                                        roleName: widget.roleName,
                                      )),
                            );
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.green,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> newData = {
                              "name": _nameController.text,
                              "description": _jobDescriptionController.text,
                              "requirement": "",
                              "position": _levelController.text,
                              "image":
                                  await uploadImageToFirebaseStorage(_image!),
                              "salary": _salaryController.text,
                              "addressWork": _workAddressController.text,
                              "endSubmission": _endSubmissionController.text,
                              "ageEmployee": _ageController.text,
                              "countEmployee": _countEmployeeController.text,
                              "formOfWork": _formOfWorkController.text,
                              "yearOfExpensive": _experienceController.text,
                              "degree": _degreeController.text,
                              "fieldId": selectedField.id
                            };
                            final response =
                                await RAService.newPost(newData, widget.token);
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
                                horizontal: 20, vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: AppColors.green,
                          ),
                          child: const Text(
                            "Đăng",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.companyImage),
                            onError: (exception, stackTrace) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.compnayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "Comfortaa",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TÊN",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
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
                          hintText: "Tên bài viết..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "MÔ TẢ CÔNG VIỆC",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: 8 * 20.0, // Giới hạn chiều cao
                          maxWidth:
                              double.infinity, // Giới hạn chiều rộng (vô hạn)
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.green, // Màu của viền
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          controller: _jobDescriptionController,
                          decoration: const InputDecoration(
                            hintText: "Mô tả công việc..",
                            border: InputBorder.none,
                          ),
                          cursorColor: AppColors.green,
                          style: const TextStyle(
                              color: AppColors.darkGreen,
                              fontSize: 15,
                              fontFamily: "Comfortaa"),
                          maxLines: null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "MỨC LƯƠNG",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _salaryController,
                        decoration: const InputDecoration(
                          hintText: "Mức lương..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "HẠN NỘP",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextFormField(
                        controller: _endSubmissionController,
                        decoration: InputDecoration(
                          hintText: "dd/MM/yyyy",
                          border: InputBorder.none,
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
                        cursorColor: AppColors.green,
                        readOnly: true,
                        style: const TextStyle(
                          color: AppColors.darkGreen,
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
                    const Text(
                      "KHU VỰC TUYỂN",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _workAddressController,
                        decoration: const InputDecoration(
                          hintText: "Khu vực tuyển..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "CẤP BẬC",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _levelController,
                        decoration: const InputDecoration(
                          hintText: "Cấp bậc..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "HÌNH THỨC LÀM VIỆC",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _formOfWorkController,
                        decoration: const InputDecoration(
                          hintText: "Cấp bậc..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "SỐ LƯỢNG TUYỂN",
                                style: TextStyle(
                                    fontFamily: "Comfortaa",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.green, // Màu của viền
                                    width: 2.0,
                                  ),
                                ),
                                child: TextField(
                                  controller: _countEmployeeController,
                                  decoration: const InputDecoration(
                                    hintText: "Số lượng tuyển..",
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: AppColors.green,
                                  style: const TextStyle(
                                      color: AppColors.darkGreen,
                                      fontSize: 15,
                                      fontFamily: "Comfortaa"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "KINH NGHIỆM",
                                style: TextStyle(
                                    fontFamily: "Comfortaa",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.green, // Màu của viền
                                    width: 2.0,
                                  ),
                                ),
                                child: TextField(
                                  controller: _experienceController,
                                  decoration: const InputDecoration(
                                    hintText: "Kinh Nghiệm..",
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: AppColors.green,
                                  style: const TextStyle(
                                      color: AppColors.darkGreen,
                                      fontSize: 15,
                                      fontFamily: "Comfortaa"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "ĐỘ TUỔI",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          hintText: "Độ tuổi..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "BẰNG CẤP",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.green, // Màu của viền
                          width: 2.0,
                        ),
                      ),
                      child: TextField(
                        controller: _degreeController,
                        decoration: const InputDecoration(
                          hintText: "Bằng cấp..",
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.green,
                        style: const TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "NGÀNH NGHỀ",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<Field>(
                        value: selectedField,
                        onChanged: (Field? newValue) {
                          setState(() {
                            selectedField = newValue!;
                          });
                        },
                        underline: Container(
                          width: MediaQuery.of(context).size.width,
                        ),
                        style: const TextStyle(
                            color: Colors.white, fontFamily: "Comfortaa"),
                        dropdownColor: Colors.black,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        items: fields.map((Field field) {
                          return DropdownMenuItem<Field>(
                            value: field,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 110,
                              child: Text(
                                field.name,
                                style: const TextStyle(
                                    fontSize: 16.0, fontFamily: "Comfortaa"),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "HÌNH ẢNH",
                      style: TextStyle(
                          fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _image == null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration:
                                const BoxDecoration(color: AppColors.gray),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Image.file(
                              _image!, // Sử dụng Image.file thay vì FileImage
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: onPressedChooseAva,
                          child: const Text(
                            "Chọn",
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 16,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.green),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
