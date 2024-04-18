// ignore_for_file: avoid_unnecessary_containers, avoid_unnecessary_containers, avoid_unnecessary_containers, duplicate_ignore, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';
import 'package:web_admin/models/employee.dart';
import 'package:web_admin/models/employer.dart';
import 'package:web_admin/models/ra.dart';
import 'package:web_admin/models/role.dart';
import 'package:web_admin/models/user.dart';
import 'package:web_admin/service/api.dart';
import 'package:web_admin/service/employeepage.dart';
import 'package:web_admin/service/employerpage.dart';
import 'package:web_admin/service/raservice.dart';
import 'package:web_admin/service/roleservice.dart';
import 'package:web_admin/widgets/header.dart';
import 'package:web_admin/widgets/table.dart';

class RaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RaPageState();
  }
}

class RaPageState extends State<RaPage> {
  List<Ra> ras = [];
  bool loading = false;
  List<List<String>> rows = [];
  List<String> columns = [];
  List<Role> roles = [];
  @override
  void initState() {
    super.initState();
    getRa();
  }

  Future<void> getRa() async {
    var list = await RaRepoService().GetAllRa(jwt: APIService.JWT());

    // var rolelist = await RoleRepoService().GetAllRole(jwt: APIService.JWT());
    print('Dữ liệu mới từ server: ${list.toString()}');

    rows.clear();
    setState(() {
      ras = List<Ra>.from(list);
      loading = true;
      // roles = List<Role>.from(rolelist);
      rows.addAll(ras.map((e) => e.toArray()));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ras.isNotEmpty) {
      columns = Ra.toName();
    }
    return loading
        ? Container(
            child: Column(
              children: [
                Header(
                  title: "Detail Recruitment",
                  button: false,
                  onAdd: () {},
                  // onAdd: () => showDialog(
                  //     context: context,
                  //     builder: (context) => _editPopup(context, null)),
                ),
                SizedBox(
                  height: 20,
                ),
                TableWidget(
                  title: "Detail Recruitment",
                  rows: rows,
                  columns: columns,
                  onEdit: (id) {
                    // final User =
                    //     users.firstWhere((element) => element.id == id);
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => _editPopup(context, User));
                  },
                  onDelete: (id) {},
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  // _editPopup(BuildContext context, User? user) {
  //   return showDialog(
  //       context: context, builder: (context) => _editPopup(context, user));
  // }
}
