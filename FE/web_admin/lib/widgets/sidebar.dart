// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_admin/core/color.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarWidgetState createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutralColor1,
      child: Column(
        children: [
          SizedBox(height: 25),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/logo_icon.svg',
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'WhatJob',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.neutralColor8,
                        fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  selected: _selectedIndex == index,
                  selectedColor: Colors.white,
                  onTap: () => _onItemTapped(index),
                  leading: Icon(
                    index == 0
                        ? Icons.home
                        : index == 1
                            ? Icons.person
                            : index == 2
                                ? Icons.settings
                                : index == 3
                                    ? Icons.notifications
                                    : Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    index == 0
                        ? 'Home'
                        : index == 1
                            ? 'Profile'
                            : index == 2
                                ? 'Settings'
                                : index == 3
                                    ? 'Notifications'
                                    : 'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
