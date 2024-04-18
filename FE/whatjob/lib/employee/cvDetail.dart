import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatjob/home/home.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/service/employeeService.dart';
import 'package:whatjob/utils/colors.dart';

class CVDetail extends StatefulWidget {
  final Employee employee;
  final String email;
  final String token;
  final String roleName;

  const CVDetail({
    Key? key,
    required this.employee,
    required this.email,
    required this.token,
    required this.roleName,
  }) : super(key: key);

  @override
  _CVDetailState createState() => _CVDetailState();
}

class _CVDetailState extends State<CVDetail> {
  String _pdfPath = "";
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.employee.cv.isNotEmpty) {
      _loadPDFFromFirebaseStorage(widget.employee.cv);
    }
  }

  Future<void> _openFilePicker() async {
    if (!_isEdit) return;

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

  String getFileNameFromPath(String path) {
    return path.split('/').last;
  }

  Future<String> _uploadFileToFirebaseStorage(String filePath) async {
    File file = File(filePath);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
        storage.ref().child('CV/${getFileNameFromPath(filePath)}');
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> _loadPDFFromFirebaseStorage(String url) async {
    setState(() {
      _pdfPath = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        iconTheme: const IconThemeData(color: AppColors.green),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex: 1, child: Container()),
            const Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'CV',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 18,
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isEdit = !_isEdit;
                  });
                  if (_isEdit && _pdfPath.isNotEmpty) {
                    String cv =
                        await _uploadFileToFirebaseStorage(_pdfPath);
                    final response = await EmployeeService.cvEdit(
                        widget.token, cv);
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
                          ),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: AppColors.green,
                ),
                child: _isEdit
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : const Text(
                        "Sửa",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Comfortaa',
                            color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_isEdit)
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
                    : ElevatedButton(
                        onPressed: _openFilePicker,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          backgroundColor: AppColors.green,
                        ),
                        child: const Text(
                          'Chọn file CV (.pdf)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Comfortaa",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          (_pdfPath.isNotEmpty || widget.employee.cv.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 580,
                    child: PDFView(
                      filePath: _pdfPath.isNotEmpty
                          ? _pdfPath
                          : (widget.employee.cv.isNotEmpty
                              ? widget.employee.cv
                              : ""),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
