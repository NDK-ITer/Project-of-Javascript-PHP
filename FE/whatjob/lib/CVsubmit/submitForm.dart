import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatjob/CVsubmit/congrate.dart';
import 'package:whatjob/home/home.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/service/raService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';

class SubmitForm extends StatefulWidget {
  final String token;
  final String roleName;
  final String email;
  final String postId;
  final Employee employee;

  const SubmitForm({
    super.key,
    required this.token,
    required this.roleName,
    required this.email,
    required this.postId,
    required this.employee,
  });

  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _pdfPath = "";
  late DateTime selectedDate = DateTime.now();

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

  int _selectedValue = 1;

  void _selectGender(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _pdfPath = file.path!;
      });
    }
  }

  void initState() {
    super.initState();
    _nameController.text = widget.employee.fullName;
    _birthdayController.text =
        DateFormat('dd/MM/yyyy').format(widget.employee.born);
    _addressController.text = widget.employee.address;
    _phoneController.text = widget.employee.phoneNumber;
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        iconTheme: const IconThemeData(color: AppColors.green),
        title: const Text(
          'Nộp Đơn',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 18,
            color: AppColors.darkGreen,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Họ tên",
                    style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Comfortaa")),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _nameController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: "Nhập Họ Tên",
                      border: InputBorder.none,
                    ),
                    cursorColor: AppColors.darkGreen,
                    style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontFamily: "Comfortaa"),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //         child: GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           _selectedValue = 1;
                //         });
                //       },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Transform.scale(
                //             scale: 1.3,
                //             child: Radio(
                //               value: 1,
                //               groupValue: _selectedValue,
                //               activeColor: AppColors.darkGreen,
                //               onChanged: (value) => _selectGender(value!),
                //             ),
                //           ),
                //           const Text(
                //             "Nam",
                //             style: TextStyle(
                //                 fontSize: 15,
                //                 fontFamily: "Comfortaa",
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.darkGreen),
                //           ),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //         ],
                //       ),
                //     )),
                //     Expanded(
                //         child: GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           _selectedValue = 2;
                //         });
                //       },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Transform.scale(
                //             scale: 1.3,
                //             child: Radio(
                //               value: 2,
                //               groupValue: _selectedValue,
                //               activeColor: AppColors.darkGreen,
                //               onChanged: (value) => _selectGender(value!),
                //             ),
                //           ),
                //           const Text(
                //             "Nữ",
                //             style: TextStyle(
                //                 fontSize: 15,
                //                 fontFamily: "Comfortaa",
                //                 fontWeight: FontWeight.bold,
                //                 color: AppColors.darkGreen),
                //           ),
                //         ],
                //       ),
                //     )),
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Ngày Sinh",
                    style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Comfortaa")),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: _birthdayController,
                    decoration: InputDecoration(
                      hintText: "Nhập Ngày Sinh",
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: const Icon(
                          Icons.calendar_today,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.darkGreen,
                    readOnly: true,
                    style: const TextStyle(
                      color: AppColors.darkGreen,
                      fontSize: 15,
                      fontFamily: "Comfortaa",
                    ),
                    onTap: () {
                      //_selectDate(context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Số Điện Thoại",
                    style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Comfortaa")),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _phoneController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: "Nhập Số Điện Thoại",
                      border: InputBorder.none,
                    ),
                    cursorColor: AppColors.darkGreen,
                    style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontFamily: "Comfortaa"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Địa Chỉ",
                    style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Comfortaa")),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _addressController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: "Nhập địa chỉ",
                      border: InputBorder.none,
                    ),
                    cursorColor: AppColors.darkGreen,
                    style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontFamily: "Comfortaa"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Email",
                    style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Comfortaa")),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: "Nhập Email",
                      border: InputBorder.none,
                    ),
                    cursorColor: AppColors.darkGreen,
                    style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontFamily: "Comfortaa"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    "CV: ",
                    style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 15,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _pdfPath.isNotEmpty
                      ? Row(
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 260,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SvgPicture.asset(
                                        'assets/svg/pdf_ic.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Text(
                                        _pdfPath.split('/').last,
                                        style: const TextStyle(
                                          color: AppColors.darkGreen,
                                          fontSize: 15,
                                          fontFamily: "Comfortaa",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _pdfPath = "";
                                });
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.darkGreen,
                              ),
                            )
                          ],
                        )
                      : Container()
                      // : ElevatedButton(
                      //     onPressed: () {
                      //       _openFilePicker();
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(13),
                      //       ),
                      //       backgroundColor: AppColors.green,
                      //     ),
                      //     child: const Text(
                      //       'Chọn file CV (.pdf)',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 15,
                      //         fontFamily: "Comfortaa",
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                ],
              )
            ],
          ),
          (_pdfPath.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                      width: double.infinity,
                      height: 580,
                      child: PDFView(
                        filePath: _pdfPath,
                      )),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "BẠN ĐÃ CHẮC CHẮN NỘP?",
                          style: TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontFamily: "Comfortaa",
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        content: const Text(
                          "Hãy đảm bảo rằng các thông tin bạn cung cấp hoàn toàn chính xác",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: AppColors.red,
                                ),
                                child: const Text(
                                  "Kiểm tra lại",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Comfortaa',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 10), // Thêm khoảng cách giữa hai nút
                              ElevatedButton(
                                onPressed: () async {
                                  print("here");
                                  print(widget.token);
                                  print(widget.postId);
                                  final response = await RAService.apply(
                                      widget.token, widget.postId);
                                  final responseData =
                                      json.decode(response.body);
                                  final int state = responseData['state'];
                                  if (state == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Congrate(
                                          token: widget.token,
                                          email: widget.email,
                                          roleName: widget.roleName,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: AppColors.green,
                                ),
                                child: const Text(
                                  "Nộp ngay",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Comfortaa',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: AppColors.green,
                ),
                child: const Text(
                  "Gửi",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
