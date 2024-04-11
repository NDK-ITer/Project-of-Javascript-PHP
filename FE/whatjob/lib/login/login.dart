import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatjob/home/home.dart';
import 'package:whatjob/model/user.dart';
import 'package:whatjob/service/userService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
            padding: EdgeInsets.only(left: 35, top: 150),
            child: Text(
              "LOGIN",
              style: TextStyle(
                  color: AppColors.green,
                  fontFamily: "Comfortaa",
                  fontSize: 50,
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
                        Container(
                          alignment:
                              Alignment.centerRight, // Căn nội dung về bên phải
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () => _login(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: AppColors.green,
                          ),
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 20),
                          child: Row(
                            children: [
                              const Text("Don't have account?",
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Comfortaa')),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () {},
                                  child: const Text("Sign Up",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Comfortaa',
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold)))
                            ],
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

  void _login(BuildContext context) async {
    String username = _emailController.text;
    String password = _passwordController.text;

    // Validate username and password
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cần nhập username và password.'),
        ),
      );
      return; // Exit the function if fields are empty
    }

    Map<String, dynamic> userData = {
      'email': username,
      'password': password,
    };

    try {
      final response = await UserService.login(userData);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final int state = responseData['state'];
        final userDataJson = responseData['data'];
        final User user = User.fromJson(userDataJson);
        
        if (state == 1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(
              user: user,
            ),
          ));
        } else {
          final String errorMessage = responseData['mess'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to login. Please try again later.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login. Please try again later.'),
        ),
      );
    }
  }

}
