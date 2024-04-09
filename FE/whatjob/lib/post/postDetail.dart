import 'package:flutter/material.dart';
import 'package:whatjob/post/post.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final String _avatar =
      'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.darkGreen,
                            size: 30,
                          ),
                          onPressed: () {
                            //Navigator.of(context).pop();
                          },
                        ),
                      ),
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
                        flex: 6,
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
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "TUYỂN CỘNG TÁC VIÊN IT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child:
                    Image.asset('assets/images/ava.jpg', fit: BoxFit.fitWidth),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "THÔNG TIN CHUNG",
                        style: TextStyle(
                            fontFamily: "Comfortaa",
                            color: AppColors.darkGreen,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFB8EAE3).withOpacity(0.7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/date.svg',
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Ngày đăng: ",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkGreen),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "04/04/2023",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/level.svg',
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cấp bậc",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.darkGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Chuyên viên - Nhân viên",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/amount.svg',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Số lượng tuyển",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 13,
                                                color: AppColors.darkGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "20",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/age.svg',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Độ tuổi",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 13,
                                                color: AppColors.darkGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "22 - 30 tuổi",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/certificate.svg',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Bằng Cấp",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 13,
                                                color: AppColors.darkGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Đại Học",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/exp.svg',
                                        height: 40,
                                        width: 40,
                                      ),
                                      const SizedBox(width: 10),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Kinh Nghiệm",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 13,
                                                color: AppColors.darkGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "1 năm",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/method.svg',
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hình Thức Làm Việc",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.darkGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Toàn thời gian cố định",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/job.svg',
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ngành nghề",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.darkGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Công Nghệ Thông Tin",
                                        style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "MỨC LƯƠNG - HẠN NỘP - KHU VỰC",
                        style: TextStyle(
                            fontFamily: "Comfortaa",
                            color: AppColors.darkGreen,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(children: [
                            Row(
                              children: [
                                Text(
                                  "Mức Lương: ",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkGreen),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "20 - 25 triệu",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Hạn nộp: ",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkGreen),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "20/04/2023",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Khu Vực: ",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkGreen),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "TP.HCM, Cần Thơ, Hà Nội",
                                  style: TextStyle(
                                      fontFamily: "Comfortaa",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "MÔ TẢ CÔNG VIỆC",
                        style: TextStyle(
                            fontFamily: "Comfortaa",
                            color: AppColors.darkGreen,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "A là công ty đã có 10 năm kinh nghiệm trong việc lừa đảo những em trai tơ gái mơ. Nay công ty của chúng tôi muốn kết nạp thêm thành viên mới với mong muốn làm cho công ty nên lớn mạnh lớn. Với lợi nhuận 10%/1 lần lừa đảo, mức lương có thể lên tới 50tr, hứa hẹn sẽ là 1 công việc không lừa đảo.\n\n YÊU CẦU: \n   -Công việc cần làm A\n   -Công việc cần làm A\n   -Công việc cần làm A\n   -Công việc cần làm A\n   -Công việc cần làm A\n   -Công việc cần làm A\n   -Công việc cần làm A\n   -Công việc cần làm A\n\nA là công ty đã có 10 năm kinh nghiệm trong việc lừa đảo những em trai tơ gái mơ. Nay công ty của chúng tôi muốn kết nạp thêm thành viên mới với mong muốn làm cho công ty nên lớn mạnh lớn. Với lợi nhuận 10%/1 lần lừa đảo, mức lương có thể lên tới 50tr, hứa hẹn sẽ là 1 công việc không lừa đảo.",
                              style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 14,
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: AppColors.green,
                          ),
                          child: const Text(
                            "Nộp Đơn Ngay",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Comfortaa',
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
