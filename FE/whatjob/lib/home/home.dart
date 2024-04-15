import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatjob/employee/employeeInfo.dart';
import 'package:whatjob/employer/employerHomeInfo.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/model/employer.dart';
import 'package:whatjob/model/post.dart';
import 'package:whatjob/model/role.dart';
import 'package:whatjob/model/user.dart';
import 'package:whatjob/post/post.dart';
import 'package:whatjob/service/employeeService.dart';
import 'package:whatjob/service/employerService.dart';
import 'package:whatjob/service/raService.dart';
import 'package:whatjob/service/roleSerivce.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  final String token;
  final String roleName;
  final String email;

  const Home({
    super.key,
    required this.token,
    required this.roleName,
    required this.email,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isDoneUpdatingDistance = false;
  late Employee employee;
  late Employer employer;

  void _getUserInfo(String token) async {
    try {
      print(widget.roleName);
      if (widget.roleName == "Employee") {

        final employeeResponse = await EmployeeService.getInfo(token);
        final employeeData = json.decode(employeeResponse.body);
        final userDataJson = employeeData['data'];

        employee = Employee.fromJson(userDataJson);
print(employee.toString());
      } else {
        final employerResponse = await EmployerService.getInfo(token);
        final employerData = json.decode(employerResponse.body);
        final userDataJson = employerData['data'];
        employer = Employer.fromJson(userDataJson);
        print(employer.toString());
      }
    } catch (e) {
      print('Failed to get user info: $e');
    }

    setState(() {
      _isDoneUpdatingDistance = true;
    });
  }

  String splitName(String fullName) {
    List<String> names = fullName.split(" ");
    String lastName = names[names.length - 1];
    return lastName;
  }

  List<PostClass> postList = [];
  Future<void> _loadPosts() async {
    try {
      List<PostClass> fetchedPosts = await RAService.fetchPublicItems(token: widget.token);
      setState(() {
        postList = fetchedPosts;
      });
    } catch (e) {
      // Handle error
      print('Error loading posts: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    employee = Employee.empty();
    employer = Employer.empty();
    _getUserInfo(widget.token);
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: !_isDoneUpdatingDistance
          ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
              ),
          )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                          child: Column(children: [
                        for (int i = 0; i < postList.length; i++)
                          Post(
                            post: postList[i],
                          ),
                      ]))),
                ),
                Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: const BoxDecoration(color: AppColors.yellow),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                onPressed: () async {
                                  widget.roleName == "Employee"
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployeeInfo(
                                                    token: widget.token,
                                                    email: widget.email,
                                                    employee: employee,
                                                    roleName: widget.roleName,
                                                  )))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployerHomeInfo(
                                                    token: widget.token,
                                                    email: widget.email,
                                                    roleName: widget.roleName,
                                                  )));
                                },
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
                                    // widget.roleName == "Employee"
                                    //     ? employee.avatar == ""
                                    //         ? Container(
                                    //             width: 30,
                                    //             height: 30,
                                    //             decoration: BoxDecoration(
                                    //               shape: BoxShape.circle,
                                    //               image: DecorationImage(
                                    //                 fit: BoxFit.cover,
                                    //                 image: const AssetImage(
                                    //                     'assets/images/default-avatar.jpg'),
                                    //                 onError: (exception,
                                    //                     stackTrace) {},
                                    //               ),
                                    //             ),
                                    //           )
                                    //         : Container(
                                    //             width: 30,
                                    //             height: 30,
                                    //             decoration: BoxDecoration(
                                    //               shape: BoxShape.circle,
                                    //               image: DecorationImage(
                                    //                 fit: BoxFit.cover,
                                    //                 image: NetworkImage(employee.avatar),
                                    //                 onError: (exception,
                                    //                     stackTrace) {},
                                    //               ),
                                    //             ),
                                    //           )
                                    //     : employer.logo == ""
                                    //         ? Container(
                                    //             width: 30,
                                    //             height: 30,
                                    //             decoration: BoxDecoration(
                                    //               shape: BoxShape.circle,
                                    //               image: DecorationImage(
                                    //                 fit: BoxFit.cover,
                                    //                 image: const AssetImage(
                                    //                     'assets/images/default-avatar.jpg'),
                                    //                 onError: (exception,
                                    //                     stackTrace) {},
                                    //               ),
                                    //             ),
                                    //           )
                                    //         : Container(
                                    //             width: 30,
                                    //             height: 30,
                                    //             decoration: BoxDecoration(
                                    //               shape: BoxShape.circle,
                                    //               image: DecorationImage(
                                    //                 fit: BoxFit.cover,
                                    //                 image: NetworkImage(
                                    //                     employer.logo),
                                    //                 onError: (exception,
                                    //                     stackTrace) {},
                                    //               ),
                                    //             ),
                                    //           ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    widget.roleName == "Employee"
                                        ? Text(splitName(employee.fullName),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Comfortaa',
                                                color: AppColors.green,
                                                fontWeight: FontWeight.bold))
                                        : Text(splitName(employer.companyName),
                                            style: const TextStyle(
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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
