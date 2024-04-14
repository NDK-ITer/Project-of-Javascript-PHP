import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatjob/employer/employerEditInfo.dart';
import 'package:whatjob/login/login.dart';
import 'package:whatjob/model/employee.dart';
import 'package:whatjob/model/employer.dart';
import 'package:whatjob/post/newPost.dart';
import 'package:whatjob/post/post.dart';
import 'package:whatjob/service/employerService.dart';
import 'package:whatjob/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

class EmployerHomeInfo extends StatefulWidget {
  final String token;
  final String email;
  final String roleName;

  const EmployerHomeInfo({
    super.key,
    required this.token,
    required this.email,
    required this.roleName,
  });

  @override
  _EmployerHomeInfoState createState() => _EmployerHomeInfoState();
}

class _EmployerHomeInfoState extends State<EmployerHomeInfo> {
  List<String> items = ["Bài Viết", "Thông Tin"];
  final String _avatar =
      'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';

  int _selectedIndex = 0;

  late Widget _selectedWidget;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _selectedWidget = BlogPosts(
          employer: employer,
          email: widget.email,
          token: widget.token,
          roleName: widget.roleName,
        );
      } else {
        _selectedWidget = CompanyInfo(
          employer: employer,
          email: widget.email,
          token: widget.token,
          roleName: widget.roleName,
        );
      }
    });
  }

  bool _isDoneUpdatingDistance = false;
  late Employer employer;

  void _getUserInfo(String token) async {
    try {
      final employerResponse = await EmployerService.getInfo(token);
      final employerData = json.decode(employerResponse.body);
      final userDataJson = employerData['data'];
      employer = Employer.fromJson(userDataJson);
      _selectedWidget = BlogPosts(
        employer: employer,
        email: widget.email,
        token: widget.token,
        roleName: widget.roleName,
      );
    } catch (e) {
      print('Failed to get user info: $e');
    }

    setState(() {
      _isDoneUpdatingDistance = true;
    });
  }

  @override
  void initState() {
    super.initState();
    employer = Employer.empty();
    _getUserInfo(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.yellow,
        resizeToAvoidBottomInset: false,
        body: !_isDoneUpdatingDistance
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 10),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(employer.logo),
                                    onError: (exception, stackTrace) {},
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        employer.companyName,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Comfortaa",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, right: 5),
                                      child: Text(
                                        "Mãi giàu, giàu mãi, mãi giàu",
                                        style: TextStyle(
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
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 20),
                      color: AppColors.yellow,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _onItemTapped(0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 18),
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: _selectedIndex == 0
                                    ? AppColors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Bài Viết',
                                style: TextStyle(
                                    color: _selectedIndex == 0
                                        ? Colors.white
                                        : AppColors.green,
                                    fontFamily: "Comfortaa",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _onItemTapped(1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 18),
                              margin: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: _selectedIndex == 1
                                    ? AppColors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                'Thông tin',
                                style: TextStyle(
                                    color: _selectedIndex == 1
                                        ? Colors.white
                                        : AppColors.green,
                                    fontFamily: "Comfortaa",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _selectedWidget,
                  ],
                ),
              ));
  }
}

class BlogPosts extends StatefulWidget {
  final String token;
  final String email;
  final Employer employer;
  final String roleName;

  const BlogPosts({
    Key? key,
    required this.token,
    required this.email,
    required this.employer,
    required this.roleName,
  }) : super(key: key);

  @override
  _BlogPostsState createState() => _BlogPostsState();
}

class _BlogPostsState extends State<BlogPosts> {
  @override
  Widget build(BuildContext context) {
    const String _avatar =
        'https://firebasestorage.googleapis.com/v0/b/pbox-b4a17.appspot.com/o/Avatar%2FIMG_1701620785499_1701620796631.jpg?alt=media&token=d0013b7b-b214-486e-8082-c0870ee56b86';

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NewPost(
                        companyImage: widget.employer.logo,
                        compnayName: widget.employer.companyName,
                        email: widget.email,
                        token: widget.token,
                        roleName: widget.roleName,
                      )),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Thêm bài tuyển dụng",
                  style: TextStyle(
                      color: AppColors.green,
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.employer.logo),
                            onError: (exception, stackTrace) {},
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Lời mời chiêu mộ tài năng",
                        style: TextStyle(
                            fontFamily: "Comfortaa",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        for (int i = 0; i < 3; i++) const Post(),
      ],
    );
  }
}

class CompanyInfo extends StatefulWidget {
  final Employer employer;
  final String email;
  final String token;
  final String roleName;
  const CompanyInfo({
    super.key,
    required this.employer,
    required this.email,
    required this.token,
    required this.roleName,
  });

  @override
  _CompanyInfoState createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  late GoogleMapController _controller;
  LatLng? _initialLocation;

  @override
  void initState() {
    super.initState();
    _getLocationFromAddress();
  }

  Future<void> _getLocationFromAddress() async {
    try {
      List<Location> locations =
          await locationFromAddress(widget.employer.address);
      if (locations.isNotEmpty) {
        final LatLng latLng =
            LatLng(locations.first.latitude, locations.first.longitude);
        setState(() {
          _initialLocation = latLng;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "MÔ TẢ",
            style: TextStyle(
                fontFamily: "Comfortaa",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Text(
              widget.employer.description,
              style: const TextStyle(
                  fontFamily: "Comfortaa",
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 9,
                child: Text(
                  "THÔNG TIN DOANH NGHIỆP",
                  style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployerEditInfo(
                                employer: widget.employer,
                                token: widget.token,
                                email: widget.email,
                                roleName: widget.roleName,
                              )),
                    );
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        "Email: ",
                        style: TextStyle(
                            fontFamily: "Comfortaa",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.email,
                        style: const TextStyle(
                            fontFamily: "Comfortaa",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.employer.address,
                        style: const TextStyle(
                            fontFamily: "Comfortaa",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                        "Hotline:",
                        style: TextStyle(
                            fontFamily: "Comfortaa",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        widget.employer.hotLine,
                        style: const TextStyle(
                            fontFamily: "Comfortaa",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "VỊ TRÍ",
            style: TextStyle(
                fontFamily: "Comfortaa",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen), // AppColors.darkGreen
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: _initialLocation != null
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initialLocation!,
                        zoom: 15,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('Marker'),
                          position: _initialLocation!,
                        ),
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('token', "");
                prefs.setString('roleName', "");
                prefs.setString('email', "");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: AppColors.green, // AppColors.green
              ),
              child: const Text(
                "Đăng Xuất",
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Comfortaa', color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
