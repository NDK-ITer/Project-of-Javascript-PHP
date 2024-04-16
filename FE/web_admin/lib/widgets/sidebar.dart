// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_admin/core/color.dart';

class SidebarWidget extends StatefulWidget {
  final Function(String data) onItemTap;
  final Widget logo;
  final String title;
  final List<Map<String, dynamic>> sidebarItems;
  const SidebarWidget(
      {super.key,
      required this.onItemTap,
      required this.logo,
      required this.title,
      required this.sidebarItems});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarWidgetState createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  void _onItemTapped({int? index_parent, int index_child = -1}) {
    setState(() {
      for (int i = 0; i < widget.sidebarItems.length; i++) {
        if (i == index_parent && index_child == -1) {
          widget.sidebarItems[i]['selected'] =
              !widget.sidebarItems[i]['selected'];
        } else if (index_child == -1) {
          widget.sidebarItems[i]['selected'] = false;
        }
        for (int j = 0; j < widget.sidebarItems[i]['items'].length; j++) {
          if (j == index_child) {
            widget.sidebarItems[i]['items'][j]['selected'] =
                !widget.sidebarItems[i]['items'][j]['selected'];
          } else {
            widget.sidebarItems[i]['items'][j]['selected'] = false;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralColor1,
        border: Border(
          right: BorderSide(
            color: AppColors.neutralColor2,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 25),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  widget.logo,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.title,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < widget.sidebarItems.length; i++) ...[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _onItemTapped(index_parent: i);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(
                                      widget.sidebarItems[i]['icon'],
                                      color: widget.sidebarItems[i]['selected']
                                          ? AppColors.primaryColor1
                                          : AppColors.neutralColor5,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(widget.sidebarItems[i]['text'],
                                      style: TextStyle(
                                          color: widget.sidebarItems[i]
                                                  ['selected']
                                              ? AppColors.primaryColor1
                                              : AppColors.neutralColor5,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(
                                  widget.sidebarItems[i]['selected']
                                      ? Icons.keyboard_arrow_down
                                      : Icons.navigate_next,
                                  color: AppColors.neutralColor5,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          if (widget.sidebarItems[i]['selected']) ...[
                            for (int j = 0;
                                j < widget.sidebarItems[i]['items'].length;
                                j++) ...[
                              GestureDetector(
                                onTap: () {
                                  widget.onItemTap(widget.sidebarItems[i]
                                      ['items'][j]['text']);
                                  _onItemTapped(
                                      index_parent: i, index_child: j);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 40,
                                        decoration: ShapeDecoration(
                                          color: widget.sidebarItems[i]['items']
                                                  [j]['selected']
                                              ? AppColors.primaryColor1
                                              : AppColors.neutralColor1,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.60,
                                                color: widget.sidebarItems[i]
                                                        ['items'][j]['selected']
                                                    ? AppColors.primaryColor1
                                                    : AppColors.neutralColor1),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                bottomLeft: Radius.circular(4)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            color: widget.sidebarItems[i]
                                                    ['items'][j]['selected']
                                                ? AppColors.neutralColor3
                                                : AppColors.neutralColor1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4)),
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Text(
                                                  widget.sidebarItems[i]
                                                      ['items'][j]['text'],
                                                  style: TextStyle(
                                                      color: widget.sidebarItems[
                                                                  i]['items'][j]
                                                              ['selected']
                                                          ? AppColors
                                                              .neutralColor8
                                                          : AppColors
                                                              .neutralColor5,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                          ]
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
                Divider(
                  color: AppColors.neutralColor4,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: AppColors.neutralColor5,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text('Settings',
                          style: TextStyle(
                            color: AppColors.neutralColor5,
                            fontSize: 14,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: AppColors.neutralColor5,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text('Logout',
                          style: TextStyle(
                            color: AppColors.neutralColor5,
                            fontSize: 14,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
