import 'package:flutter/material.dart';
import 'package:whatjob/CVsubmit/congrate.dart';
import 'package:whatjob/CVsubmit/submitForm.dart';
import 'package:whatjob/employee/employeeInfo.dart';
import 'package:whatjob/employer/employerHomeInfo.dart';
import 'package:whatjob/login/login.dart';
import 'package:whatjob/post/newPost.dart';
import 'package:whatjob/signup/signup.dart';
import 'package:whatjob/signup/signupEmployee.dart';
import 'package:whatjob/signup/signupEmployer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewPost(),
    );
  }
}