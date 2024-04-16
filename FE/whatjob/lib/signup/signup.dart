import 'package:flutter/material.dart';
import 'package:whatjob/signup/signupEmployee.dart';
import 'package:whatjob/signup/signupEmployer.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _comfirmPasswordController = TextEditingController();
  String _selectedRole = 'Employee';

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
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: SvgPicture.asset(
                                  'assets/svg/user.svg',
                                ),
                              ),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            hintStyle: const TextStyle(
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "PassWord",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/svg/lock.svg',
                                ),
                              ),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            hintStyle: const TextStyle(
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
                          controller: _comfirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Comfirm PassWord",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/svg/lock.svg',
                                ),
                              ),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.green),
                            ),
                            hintStyle: const TextStyle(
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
                            value: _selectedRole,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRole = newValue!;
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
                            items: <String>[
                              'Employee',
                              'Employer',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 175,
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
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_passwordController.text ==
                                _comfirmPasswordController.text) {
                              if (_selectedRole == 'Employee') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpEmployee(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpEmployer(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  ),
                                );
                              }
                            } else {
                              // Nếu mật khẩu và xác nhận mật khẩu không trùng nhau, xuất thông báo
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Password and Confirm Password do not match!'),
                                ),
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
                            "Next",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
