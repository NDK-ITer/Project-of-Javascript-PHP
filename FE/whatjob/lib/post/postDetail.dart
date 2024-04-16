import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatjob/CVsubmit/submitForm.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/model/raDetail.dart';
import 'package:whatjob/post/post.dart';
import 'package:whatjob/service/raService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatefulWidget {
  final String postId;
  final String logo;
  final String companyName;
  final String token;
  final String roleName;
  final String email;
  final Employee employee;

  const PostDetail({
    super.key,
    required this.postId,
    required this.logo,
    required this.companyName,
    required this.token,
    required this.roleName,
    required this.email,
    required this.employee,
  });

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  late RADetail raDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    raDetail = RADetail.empty();
    _loadRADetail();
  }

  Future<void> _loadRADetail() async {
    try {
      final raDetailRp = (await RAService.fetchRADetail(widget.postId));
      print(raDetailRp.body);
      final responseData = json.decode(raDetailRp.body);
      final userDataJson = responseData['data'];
      raDetail = RADetail.fromJson(userDataJson);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading RADetail: $e');
    }
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
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
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(widget.logo),
                                      onError: (exception, stackTrace) {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.companyName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Comfortaa",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
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
                        Text(
                          raDetail.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Image.network(
                            raDetail.image,
                            fit: BoxFit.fitWidth,
                          ),
                        )),
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
                                      Text(
                                        formatDate(raDetail.dateUpload)
                                            .toString(),
                                        style: const TextStyle(
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Cấp bậc",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 13,
                                                color: AppColors.darkGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              raDetail.position,
                                              style: const TextStyle(
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Số lượng tuyển",
                                                    style: TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.darkGreen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    raDetail.countEmployee
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Độ tuổi",
                                                    style: TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.darkGreen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    raDetail.ageEmployee,
                                                    style: const TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Bằng Cấp",
                                                    style: TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.darkGreen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    raDetail.degree,
                                                    style: const TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Kinh Nghiệm",
                                                    style: TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.darkGreen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "${raDetail.yearOfExperience} năm",
                                                    style: const TextStyle(
                                                      fontFamily: "Comfortaa",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Hình Thức Làm Việc",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 13,
                                                color: AppColors.darkGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              raDetail.formOfWork,
                                              style: const TextStyle(
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Ngành nghề",
                                              style: TextStyle(
                                                fontFamily: "Comfortaa",
                                                fontSize: 13,
                                                color: AppColors.darkGreen,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              raDetail.fieldName,
                                              style: const TextStyle(
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
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Mức Lương: ",
                                        style: TextStyle(
                                            fontFamily: "Comfortaa",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkGreen),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        raDetail.salary,
                                        style: const TextStyle(
                                            fontFamily: "Comfortaa",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Hạn nộp: ",
                                        style: TextStyle(
                                            fontFamily: "Comfortaa",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkGreen),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        formatDate(raDetail.endSubmission)
                                            .toString(),
                                        style: const TextStyle(
                                            fontFamily: "Comfortaa",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Khu Vực: ",
                                        style: TextStyle(
                                            fontFamily: "Comfortaa",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkGreen),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        raDetail.addressWork,
                                        style: const TextStyle(
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
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    raDetail.description,
                                    style: const TextStyle(
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubmitForm(
                                              employee: widget.employee,
                                              token: widget.token,
                                              email: widget.email,
                                              roleName: widget.roleName,
                                              postId: widget.postId,
                                            )),
                                  );
                                },
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
