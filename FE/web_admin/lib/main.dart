import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';
import 'package:web_admin/home.dart';
import 'package:web_admin/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Admin WhatJob',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(AppColors.neutralColor7),
          trackColor: MaterialStateProperty.all(AppColors.neutralColor3),
        ),
        fontFamily: 'Comfortaa',
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
