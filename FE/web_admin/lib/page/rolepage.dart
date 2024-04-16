// ignore_for_file: avoid_unnecessarainers, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';
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
  List<List<String>> rows = [];
  List<String> columns = [];
  @override
  void initState() {
    super.initState();
    getRole();
    // RoleRepoService().GetAllRole(jwt: APIService.JWT()).then((data) {
    //   setState(() {
    //     roles = List<Role>.from(data);
    //
    //   });
    // });
  }

  Future<void> getRole() async {
    var list = await RoleRepoService().GetAllRole(jwt: APIService.JWT());
    print('Dữ liệu mới từ server: ${list.toString()}');

    // setState(() {
    //   roles = List<Role>.from(list);
    //   loading = true;
    //   rows = [];
    //   // rows.addAll(roles.map((e) => e.toArray()));
    // });
    rows.clear();
    setState(() {
      roles = List<Role>.from(list);
      loading = true;

      rows.addAll(roles.map((e) => e.toArray()));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (roles.isNotEmpty) {
      columns = Role.toName();
    }
    return loading
        ? Container(
            child: Column(
              children: [
                Header(
                  title: "Role",
                  onAdd: () => showDialog(
                      context: context,
                      builder: (context) => _editPopup(context, null)),
                ),
                SizedBox(
                  height: 20,
                ),
                TableWidget(
                  title: "Role",
                  rows: rows,
                  columns: columns,
                  onEdit: (id) {
                    final role =
                        roles.firstWhere((element) => element.id == id);
                    showDialog(
                        context: context,
                        builder: (context) => _editPopup(context, role));
                  },
                  onDelete: onDelete,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _editPopup(BuildContext context, Role? role) {
    TextEditingController _nameController =
        TextEditingController(text: role == null ? '' : role.name);

    return AlertDialog(
      backgroundColor: AppColors.neutralColor3,
      title: role == null
          ? Text(
              "Create Role",
              style: TextStyle(color: AppColors.neutralColor8),
            )
          : Text(
              "Edit Role",
              style: TextStyle(color: AppColors.neutralColor8),
            ),
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400),
        child: TextField(
          controller: _nameController,
          style: TextStyle(color: AppColors.neutralColor8),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.neutralColor4)),
              labelText: 'Tên',
              labelStyle: TextStyle(color: AppColors.neutralColor8)),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            "Hủy",
            style: TextStyle(color: AppColors.neutralColor8),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            "Sửa",
            style: TextStyle(color: AppColors.neutralColor8),
          ),
          onPressed: () async {
            if (role == null) {
              var roleAdd = Role(
                name: _nameController.text,
                normalizeName: '',
              );
              addRole(roleAdd);
              getRole();
            } else {
              role.name = _nameController.text;
              editRole(role);
              Navigator.pop(context);
              getRole();
            }
            // Role updatedRole = role.copyWith(name: _nameController.text);
            // await RoleRepoService().UpdateRole(updatedRole,
            //     jwt: APIService.JWT());
            // Navigator.pop(context);
            // setState(() {});
          },
        ),
      ],
    );
  }

  void onDelete(String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: AppColors.neutralColor3,
              title: Text(
                "Xóa",
                style: TextStyle(color: AppColors.neutralColor8),
              ),
              content: Text("Bạn có chắc chắn muốn xóa?",
                  style: TextStyle(color: AppColors.neutralColor8)),
              actions: [
                TextButton(
                  child: Text("Hủy",
                      style: TextStyle(color: AppColors.neutralColor8)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Xóa",
                      style: TextStyle(color: AppColors.neutralColor8)),
                  onPressed: () async {
                    final role =
                        roles.firstWhere((element) => element.id == id);
                    deleteRole(role);
                    Navigator.pop(context);
                    getRole();
                  },
                ),
              ],
            ));
  }

  void addRole(Role role) {
    var result = RoleRepoService().CreateRole(
      role: role,
    );
    // print(result);
  }

  void editRole(Role role) {
    var result = RoleRepoService().UpdateRole(
      role: role,
    );
  }

  void deleteRole(Role role) {
    var result = RoleRepoService().DeleteRole(
      role: role,
    );
  }
}
