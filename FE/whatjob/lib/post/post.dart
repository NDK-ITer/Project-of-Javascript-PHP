import 'package:flutter/material.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final String _avatar =
      'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_avatar),
                                onError: (exception, stackTrace) {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Công ty A - Trùm Đa Cấp",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "5 phút trước",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Comfortaa",
                                  color: AppColors.gray),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/svg/menu.svg',
                          height: 5,
                          width: 5,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "TUYỂN CỘNG TÁC VIÊN IT",
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "A là công ty đã có 10 năm kinh nghiệm trong việc lừa đảo những em trai tơ gái mơ. Nay công ty của chúng tôi muốn kết nạp thêm thành viên mới với mong muốn làm cho công ty nên lớn mạnh lớn. Với lợi nhuận 10%/1 lần lừa đảo, mức lương...",
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightGreen,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppColors.green, // Màu của viền
                              width: 2.0,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Mức lương: 20 - 25 triệu",
                              style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Image.asset('assets/images/ava.jpg', fit: BoxFit.fitWidth),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 55,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Liên Hệ",
                      style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 55,
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        color: AppColors.green),
                    child: const Center(
                        child: Text(
                      "Chi tiết",
                      style: TextStyle(
                          fontFamily: "Comfortaa",
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
