import 'package:flutter/material.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.yellow,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * (2 / 2.92),
              child: Image.asset(
                'assets/images/welcome.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 5),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Wanna find a job?",
                      style: TextStyle(
                          color: AppColors.green,
                          fontFamily: 'Oswald',
                          fontSize: 35),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Come with us! They are finding you too!",
                      style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 128, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: AppColors.green,
                    ),
                    child: const Text(
                      "Let's Start",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Comfortaa',
                          color: Colors.white),
                    ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.only(left: 43, top: 20),
                    child: Row(
                      children: [
                        const Text(
                          "Already have an account?",
                          style:TextStyle(fontSize: 14, fontFamily: 'Comfortaa')
                        ),
                        const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Login",
                              style: TextStyle(fontSize: 14, fontFamily: 'Comfortaa', color: AppColors.green, fontWeight: FontWeight.bold))
                        )  
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
