import 'package:flutter/material.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';

class Congrate extends StatefulWidget {
  const Congrate({super.key});

  @override
  _CongrateState createState() => _CongrateState();
}

class _CongrateState extends State<Congrate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                  child: SvgPicture.asset(
                    'assets/svg/submit_congrate.svg',
                    height: 200,
                    width: 200,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * (3 / 5),
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.8999999761581421),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 60),
                      child: Column(children: [
                        const Text(
                          "ĐÃ NỘP ĐƠN THÀNH CÔNG",
                          style: TextStyle(
                            color: AppColors.darkGreen,
                            fontSize: 20,
                            fontFamily: "Comfortaa",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 60),
                          child: Text(
                            "Hãy đợi tin tốt từ phía công ty nhé!!!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: AppColors.green),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Xem Đơn Đã Nộp",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Comfortaa',
                              color: AppColors.green,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 90, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: AppColors.green,
                          ),
                          child: const Text(
                            "Về Trang Chủ",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
