// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';
import 'package:web_admin/widgets/button.dart';

class Header extends StatelessWidget {
  final String title;
  final Function() onAdd;
  final bool button;
  Header({required this.title, required this.onAdd, required this.button});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.neutralColor8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColors.neutralColor3,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.neutralColor4),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search for ...',
                          hintStyle: TextStyle(
                              fontSize: 16, color: AppColors.neutralColor4),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.neutralColor4,
                        ),
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          button
              ? ButtonWidget(
                  text: 'Add ' + title,
                  textColor_1: AppColors.neutralColor8,
                  textColor_2: AppColors.primaryColor1,
                  backgroundColor_1: AppColors.primaryColor1,
                  backgroundColor_2: AppColors.neutralColor8,
                  onTap: onAdd,
                )
              : Container()
        ],
      ),
    );
  }
}
