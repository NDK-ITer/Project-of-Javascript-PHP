// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:web_admin/models/role.dart';
import 'package:web_admin/service/api.dart';
import 'package:web_admin/service/roleservice.dart';
import 'package:web_admin/widgets/header.dart';
import 'package:web_admin/widgets/table.dart';

class RolePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RolePageState();
  }
}

class RolePageState extends State<RolePage> {
  List<Role> roles = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();

    RoleRepoService().GetAllRole(jwt: APIService.JWT()).then((data) {
      setState(() {
        roles = List<Role>.from(data);
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> rows = [];
    List<String> columns = [];
    if (roles.isNotEmpty) {
      rows.addAll(roles.map((e) => e.toArray()));
      columns = Role.toName();
    }
    return loading
        ? Container(
            child: Column(
              children: [
                Header(title: "Role"),
                SizedBox(
                  height: 20,
                ),
                TableWidget(
                  title: "Role",
                  rows: rows,
                  columns: columns,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
