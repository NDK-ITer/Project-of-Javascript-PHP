import 'package:flutter/material.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EmployerEditInfo extends StatefulWidget {
  const EmployerEditInfo({super.key});

  @override
  _EmployerEditInfoState createState() => _EmployerEditInfoState();
}

class _EmployerEditInfoState extends State<EmployerEditInfo> {
  final String _avatar =
      'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController =  TextEditingController();
  final TextEditingController _introduceController = TextEditingController();

  String _selectedField = 'IT';

  late DateTime selectedDate;

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
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_avatar),
                  onError: (exception, stackTrace) {},
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {},
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedField,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedField = newValue!;
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
                      items: <String>['Marketing', 'IT', 'Law']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 125,
                            child: Text(
                              value,
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
                            hintText: 'Introduce',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                          ),
                          cursorColor: AppColors.green,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Comfortaa',
                          ),
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
