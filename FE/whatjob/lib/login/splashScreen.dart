import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatjob/home/home.dart';
import 'package:whatjob/login/login.dart';
import 'package:whatjob/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token') ?? "";
      String? roleName = prefs.getString('roleName') ?? "";
      String? email = prefs.getString('email') ?? "";

      if (token != "") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(token: token, roleName: roleName, email: email,)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    }

    checkToken();

    return const Scaffold(
      backgroundColor: AppColors.yellow,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
        ),
      ),
    );
  }
}
