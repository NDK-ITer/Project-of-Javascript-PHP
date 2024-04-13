import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Comfortaa',
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
