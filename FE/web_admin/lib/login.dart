// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_admin/core/color.dart';
import 'package:web_admin/home.dart';
import 'package:web_admin/widgets/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Stack(children: [
          SvgPicture.asset(
            'assets/svg/login_bg.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: AppColors.neutralColor8,
                                    fontWeight: FontWeight.w900),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontSize: 24,
                                      color: AppColors.neutralColor8),
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontSize: 24,
                                      color: AppColors.neutralColor8),
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              ButtonWidget(
                                text: 'Login',
                                textColor_1: AppColors.neutralColor3,
                                textColor_2: AppColors.neutralColor8,
                                backgroundColor_1: AppColors.neutralColor8,
                                backgroundColor_2: AppColors.neutralColor3,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )
        ])));
  }
}
