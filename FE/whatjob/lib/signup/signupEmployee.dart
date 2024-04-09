import 'package:flutter/material.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SignUpEmployee extends StatefulWidget {
  const SignUpEmployee({super.key});

  @override
  _SignUpEmployeeState createState() => _SignUpEmployeeState();
}

class _SignUpEmployeeState extends State<SignUpEmployee> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedField = 'IT';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -95,
            child: Image.asset(
              'assets/images/folder.png',
              width: 350,
              height: 350,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 145),
            child: Text(
              "SIGN UP",
              style: TextStyle(
                  color: AppColors.green,
                  fontFamily: "Comfortaa",
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: -90,
            left: -110,
            child: Image.asset(
              'assets/images/hiring.png',
              width: 400,
              height: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 235),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 100,
                          width: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 300,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    hintText: "Full Name",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
                                    hintStyle: TextStyle(
                                        color: AppColors.gray,
                                        fontSize: 15,
                                        fontFamily: "Comfortaa"),
                                  ),
                                  cursorColor: AppColors.green,
                                  style: const TextStyle(
                                      color: AppColors.green,
                                      fontSize: 15,
                                      fontFamily: "Comfortaa"),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Transform.scale(
                                            scale: 1.3,
                                            child: Radio(
                                              value: 1,
                                              groupValue: _selectedValue,
                                              activeColor: AppColors.green,
                                              onChanged: (value) =>
                                                  _selectGender(value!),
                                            ),
                                          ),
                                          const Text(
                                            "Male",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Transform.scale(
                                            scale: 1.3,
                                            child: Radio(
                                              value: 2,
                                              groupValue: _selectedValue,
                                              activeColor: AppColors.green,
                                              onChanged: (value) =>
                                                  _selectGender(value!),
                                            ),
                                          ),
                                          const Text(
                                            "Female",
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
                                TextFormField(
                                  controller: _birthdayController,
                                  decoration: InputDecoration(
                                    hintText: "Date of birth",
                                    border: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
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
                                  cursorColor: AppColors.green,
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
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: _addressController,
                                  decoration: const InputDecoration(
                                    hintText: "Address",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
                                    hintStyle: TextStyle(
                                        color: AppColors.gray,
                                        fontSize: 15,
                                        fontFamily: "Comfortaa"),
                                  ),
                                  cursorColor: AppColors.green,
                                  style: const TextStyle(
                                      color: AppColors.green,
                                      fontSize: 15,
                                      fontFamily: "Comfortaa"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: _phoneController,
                                  decoration: const InputDecoration(
                                    hintText: "PhoneNumber",
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.green),
                                    ),
                                    hintStyle: TextStyle(
                                        color: AppColors.gray,
                                        fontSize: 15,
                                        fontFamily: "Comfortaa"),
                                  ),
                                  cursorColor: AppColors.green,
                                  style: const TextStyle(
                                      color: AppColors.green,
                                      fontSize: 15,
                                      fontFamily: "Comfortaa"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
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
                                    underline: Container(width:MediaQuery.of(context).size.width,),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Comfortaa"),
                                    dropdownColor: Colors.black,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                    items: <String>['Marketing', 'IT', 'Law']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                          width:MediaQuery.of(context).size.width - 175,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: "Comfortaa"),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: AppColors.green,
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _login() {
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;

  //   // Your login logic goes here
  //   print('Username: $username');
  //   print('Password: $password');
  // }
}
