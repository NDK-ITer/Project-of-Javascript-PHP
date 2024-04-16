// ignore_for_file: avoid_unnecessary_containers, avoid_unnecessary_containers, avoid_unnecessary_containers

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

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserPageState();
  }
}

class UserPageState extends State<UserPage> {
  List<User> users = [];
  bool loading = false;
  List<List<String>> rows = [];
  List<String> columns = [];
  List<Role> roles = [];
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    var list = await UserRepoService().GetAllUser(jwt: APIService.JWT());
    var rolelist = await RoleRepoService().GetAllRole(jwt: APIService.JWT());
    print('Dữ liệu mới từ server: ${list.toString()}');

    rows.clear();
    setState(() {
      users = List<User>.from(list);
      loading = true;
      roles = List<Role>.from(rolelist);
      rows.addAll(users.map((e) => e.toArray()));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (users.isNotEmpty) {
      columns = User.toName();
    }
    return loading
        ? Container(
            child: Column(
              children: [
                Header(
                  title: "User",
                  // onAdd: () {},
                  onAdd: () => showDialog(
                      context: context,
                      builder: (context) => _editPopup(context, null)),
                ),
                SizedBox(
                  height: 20,
                ),
                TableWidget(
                  title: "User",
                  rows: rows,
                  columns: columns,
                  onEdit: (id) {
                    final User =
                        users.firstWhere((element) => element.id == id);
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

  Widget _editPopup(BuildContext context, User? user) {
    final _formKey = GlobalKey<FormState>();
    User newUser;

    return AlertDialog(
      backgroundColor: AppColors.neutralColor3,
      title: Text(
        user == null ? "Create User" : "Edit User",
        style: TextStyle(color: AppColors.neutralColor8),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              initialValue: user?.email,
              decoration: InputDecoration(
                labelText: "Email",
                //hintText: "Email",
                hintStyle: TextStyle(color: AppColors.neutralColor8),
                labelStyle: TextStyle(color: AppColors.neutralColor8),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Vui lòng nhập email";
                }
                return null;
              },
              onSaved: (value) {
                // newUser.email = value.toString();
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              dropdownColor: AppColors.neutralColor3,
              decoration: InputDecoration(
                // labelText: "Role",
                //hintText: "Role",
                hintStyle: TextStyle(color: AppColors.neutralColor8),
                labelStyle: TextStyle(color: AppColors.neutralColor8),
              ),
              value: user?.role,
              items: [
                for (var role in roles) ...[
                  DropdownMenuItem<String>(
                    value: "${role.id}",
                    child: Text(role.name,
                        style: TextStyle(color: AppColors.neutralColor8)),
                  ),
                ]
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return "Vui lòng chọn role";
                }
                return null;
              },
              onSaved: (value) {
                // newUser = newUser.copyWithRole(value);
              },
              onChanged: (String? value) {
                print(value);
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: user?.password,
              decoration: InputDecoration(
                labelText: "Password",
                //hintText: "Password",
                hintStyle: TextStyle(color: AppColors.neutralColor8),
                labelStyle: TextStyle(color: AppColors.neutralColor8),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Vui lòng nhập password";
                }
                return null;
              },
              onSaved: (value) {
                // newUser = newUser.copyWithPassword(value);
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: user?.isBlock,
              decoration: InputDecoration(
                labelText: "Block",
                //hintText: "Block",
                hintStyle: TextStyle(color: AppColors.neutralColor8),
                labelStyle: TextStyle(color: AppColors.neutralColor8),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Vui lòng nhập block";
                }
                return null;
              },
              onSaved: (value) {
                // newUser = newUser.copyWithIsBlock(value);
              },
            )
          ],
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
            User == null ? "Thêm" : "Sửa",
            style: TextStyle(color: AppColors.neutralColor8),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (User == null) {
                // addUser(newUser);
              } else {
                // editUser(newUser);
              }

              Navigator.pop(context);
              getUser();
            }
          },
        ),
      ],
    );
  }

  // void addUser(User User) {
  //   var result = UserRepoService().CreateUser(
  //     User: User,
  //   );
  //   // print(result);
  // }
}
