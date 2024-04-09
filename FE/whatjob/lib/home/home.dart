import 'package:flutter/material.dart';
import 'package:whatjob/post/post.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _avatar =
      'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Column(children: [
                      for (int i = 0; i < 3; i++) const Post(),
                    ]))),
          ),
          Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: const BoxDecoration(color: AppColors.yellow),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(_avatar),
                                    onError: (exception, stackTrace) {},
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Thư",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Comfortaa',
                                      color: AppColors.green,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 60,
                              width: 110,
                            ),
                            // const SizedBox(
                            //   width: 40,
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const SizedBox(width: 8,),
                            SizedBox(
                              width: 45,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    elevation: 7,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: AppColors.green),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/svg/search.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8,),
                            SizedBox(
                              width: 45,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    elevation: 7,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: AppColors.green),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/svg/bell.svg',
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}