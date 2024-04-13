// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_admin/core/color.dart';
import 'package:web_admin/widgets/header.dart';
import 'package:web_admin/widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String content = 'Home';

  void loadPage(String data) {
    setState(() {
      content = data;
    });
  }

  final List<Map<String, dynamic>> _sidebarItems = [
    {
      'text': 'User Management',
      'icon': Icons.people,
      'selected': false,
      'items': [
        {
          'text': 'Account',
          'selected': false,
        },
        {
          'text': 'Role',
          'selected': false,
        }
      ]
    },
    {
      'text': 'Job Management',
      'icon': Icons.work,
      'selected': false,
      'items': [
        {
          'text': 'Employer',
          'selected': false,
        },
        {
          'text': 'Detail Recruitment',
          'selected': false,
        }
      ]
    },
    {
      'text': 'Applicant Management',
      'icon': Icons.school,
      'selected': false,
      'items': [
        {
          'text': 'Employee',
          'selected': false,
        },
        {
          'text': 'Recruitment Article',
          'selected': false,
        },
      ]
    },
    {
      'text': 'Reporting',
      'icon': Icons.bar_chart,
      'selected': false,
      'items': [
        {
          'text': 'Enjoy',
          'selected': false,
        }
      ]
    },
    {
      'text': 'System Configuration',
      'icon': Icons.system_update_tv,
      'selected': false,
      'items': [
        {
          'text': 'Field',
          'selected': false,
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.neutralColor1,
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: Center(
        child: Row(
          children: [
            SizedBox(
              width: 320,
              child: SidebarWidget(
                onItemTap: loadPage,
                logo: SvgPicture.asset(
                  'assets/svg/logo_icon.svg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
                title: 'WhatJob',
                sidebarItems: _sidebarItems,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                child: Container(
                  child: Column(
                    children: [
                      Header(title: content),
                      // Text(content,
                      //     style: TextStyle(
                      //         fontSize: 20, color: AppColors.neutralColor8)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
