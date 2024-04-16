import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatjob/login/login.dart';
import 'package:whatjob/model/role.dart';
import 'package:whatjob/service/roleSerivce.dart';
import 'package:whatjob/service/userService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpEmployer extends StatefulWidget {
  final String email;
  final String password;

  const SignUpEmployer({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  _SignUpEmployerState createState() => _SignUpEmployerState();
}

class _SignUpEmployerState extends State<SignUpEmployer> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  List<Role> roles = [];

  Future<void> _fetchRoles() async {
    try {
      final List<Role> fetchedRoles = await RoleService.fetchRoles();
      setState(() {
        roles = fetchedRoles;
      });
    } catch (e) {
      print('Error fetching roles: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRoles();
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
            padding: EdgeInsets.only(left: 25, top: 155),
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
            padding: const EdgeInsets.only(top: 250),
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
                        Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                hintText: "Company Name",
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
                                hintText: "Hotline",
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
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String roleId = "";
                            for (var role in roles) {
                              if (role.name == 'Employer') {
                                roleId = role.id;
                                break;
                              }
                            }
                            Map<String, dynamic> userData = {
                              'email': widget.email,
                              'password': widget.password,
                              'roleId': roleId,
                              'employer': {
                                "companyName": _nameController.text,
                                "address": _addressController.text,
                                "hotline": _phoneController.text,
                              }
                            };
                            final respone =
                                await UserService.registerUser(userData);
                            final responseData = json.decode(respone.body);
                            final int state = responseData['state'];
                            if (state == 1) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            }
                          },
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
}
