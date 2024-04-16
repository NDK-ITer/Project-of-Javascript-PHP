import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatjob/CVsubmit/congrate.dart';
import 'package:whatjob/CVsubmit/submitForm.dart';
import 'package:whatjob/employee/cvDetail.dart';
import 'package:whatjob/employee/employeeInfo.dart';
import 'package:whatjob/employer/employerHomeInfo.dart';
import 'package:whatjob/login/login.dart';
import 'package:whatjob/post/newPost.dart';
import 'package:whatjob/signup/signup.dart';
import 'package:whatjob/signup/signupEmployee.dart';
import 'package:whatjob/signup/signupEmployer.dart';
import 'package:whatjob/login/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA-jb9J27ArBrzGChVuJemdOqmgZxgWiHY',
      authDomain: 'pbox-b4a17.firebaseapp.com',
      projectId: 'pbox-b4a17',
      storageBucket: 'pbox-b4a17.appspot.com',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      appId: '1:1049009016949:android:3aa88260719a2baf89283c',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
