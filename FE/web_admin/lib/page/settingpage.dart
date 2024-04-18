// ignore_for_file: avoid_unnecessary_containers, avoid_unnecessary_containers, avoid_unnecessary_containers, duplicate_ignore, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';
import 'package:web_admin/models/role.dart';
import 'package:web_admin/models/user.dart';
import 'package:web_admin/service/api.dart';
import 'package:web_admin/service/roleservice.dart';
import 'package:web_admin/service/userservice.dart';
import 'package:web_admin/widgets/header.dart';
import 'package:web_admin/widgets/table.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
