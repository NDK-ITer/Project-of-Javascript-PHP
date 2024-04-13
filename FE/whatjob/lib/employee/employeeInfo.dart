import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatjob/employee/employeeEditInfo.dart';
import 'package:whatjob/login/login.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class EmployeeInfo extends StatefulWidget {
  final Employee employee;
  final String email;
  final String token;
  final String roleName;
  const EmployeeInfo(
      {super.key,
      required this.employee,
      required this.email,
      required this.token,
      required this.roleName
      });

  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.green,
                        size: 30,
                      ),
                      onPressed: () {
                        //Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      flex: 5,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 60,
                        width: 110,
                      ),
                    ),
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
                    const SizedBox(
                      width: 8,
                    ),
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
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 145,
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: widget.employee.avatar.isNotEmpty
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              widget.employee.avatar),
                                          onError: (exception, stackTrace) {
                                            // Handle error if image loading fails
                                          },
                                        )
                                      : const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/default-avatar.jpg'), // Placeholder image asset path
                                        )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.employee.fullName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Comfortaa",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 5),
                                    child: Text(
                                      widget.employee.introduction ?? "",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Comfortaa",
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(shrinkWrap: true, children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 9,
                            child: Text(
                              "THÔNG TIN CÁ NHÂN",
                              style: TextStyle(
                                  fontFamily: "Comfortaa",
                                  fontSize: 14,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                'assets/svg/edit.svg',
                                height: 20,
                                width: 20,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.green,
                                  BlendMode.srcIn,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EmployeeEditInfo(
                                          employee: widget.employee,
                                          email: widget.email,
                                          token: widget.token,
                                          roleName: widget.roleName,
                                        )));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: ShapeDecoration(
                          color: AppColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 25),
                          child: Column(children: [
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Ngày sinh:",
                                      style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      formatDate(widget.employee.born),
                                      style: const TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Giới tính:",
                                      style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.employee.gender,
                                      style: const TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.email,
                                      style: const TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Địa chỉ:",
                                      style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.employee.address,
                                      style: const TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      "SĐT:",
                                      style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.employee.phoneNumber,
                                      style: const TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Chuyên ngành:",
                                      style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      "IT",
                                      style: TextStyle(
                                          fontFamily: "Comfortaa",
                                          fontSize: 13,
                                          color: AppColors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ]),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              child: Text(
                            "THÔNG TIN CV",
                            style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 14,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold),
                          )),
                          IconButton(
                            icon: Transform.rotate(
                              angle: 3.14159265,
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.green,
                                size: 20,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              child: Text(
                            "DANH SÁCH CHỨNG NHẬN",
                            style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 14,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold),
                          )),
                          IconButton(
                            icon: Transform.rotate(
                              angle: 3.14159265,
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.green,
                                size: 20,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              child: Text(
                            "LỊCH SỬ NỘP ĐƠN",
                            style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 14,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold),
                          )),
                          IconButton(
                            icon: Transform.rotate(
                              angle: 3.14159265,
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.green,
                                size: 20,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('token', "");
                        prefs.setString('roleName', "");
                        prefs.setString('email', "");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                              child: Text(
                            "ĐĂNG XUẤT",
                            style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 14,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold),
                          )),
                          IconButton(
                            icon: Transform.rotate(
                              angle: 3.14159265,
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.green,
                                size: 20,
                              ),
                            ),
                            onPressed: () {
                              //Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
