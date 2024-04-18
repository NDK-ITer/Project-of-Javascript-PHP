// ignore_for_file: avoid_unnecessary_containers, avoid_unnecessary_containers, avoid_unnecessary_containers, duplicate_ignore, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_admin/core/color.dart';
import 'package:web_admin/models/field.dart';
import 'package:web_admin/service/api.dart';
import 'package:web_admin/service/fieldservice.dart';
import 'package:web_admin/widgets/header.dart';
import 'package:web_admin/widgets/table.dart';

class FieldPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FieldPageState();
  }
}

class FieldPageState extends State<FieldPage> {
  List<Field> fields = [];
  bool loading = false;
  List<List<String>> rows = [];
  List<String> columns = [];
  @override
  void initState() {
    super.initState();
    getField();
  }

  Future<void> getField() async {
    var list = await FieldRepoService().GetAllField(jwt: APIService.JWT());

    // var rolelist = await RoleRepoService().GetAllRole(jwt: APIService.JWT());
    print('Dữ liệu mới từ server: ${list.toString()}');

    rows.clear();
    setState(() {
      fields = List<Field>.from(list);
      loading = true;
      // roles = List<Role>.from(rolelist);
      rows.addAll(fields.map((e) => e.toArray()));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fields.isNotEmpty) {
      columns = Field.toName();
    }
    return loading
        ? Container(
            child: Column(
              children: [
                Header(
                  title: "Field",
                  button: true,
                  // onAdd: () {},
                  onAdd: () => showDialog(
                      context: context,
                      builder: (context) => _editPopup(context, null)),
                ),
                SizedBox(
                  height: 20,
                ),
                TableWidget(
                  title: "Field",
                  rows: rows,
                  columns: columns,
                  onEdit: (id) {
                    final field =
                        fields.firstWhere((element) => element.id == id);
                    showDialog(
                        context: context,
                        builder: (context) => _editPopup(context, field));
                  },
                  onDelete: (id) {
                    onDelete(id);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _editPopup(BuildContext context, Field? field) {
    TextEditingController _nameController =
        TextEditingController(text: field == null ? '' : field.name);

    return AlertDialog(
      backgroundColor: AppColors.neutralColor3,
      title: field == null
          ? Text(
              "Create Field",
              style: TextStyle(color: AppColors.neutralColor8),
            )
          : Text(
              "Edit Field",
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
            if (field == null) {
              var fieldAdd = Field(
                id: '',
                name: _nameController.text,
              );
              addField(fieldAdd);
              getField();
            } else {
              field.name = _nameController.text;
              editField(field);
              Navigator.pop(context);
              getField();
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
                    final field =
                        fields.firstWhere((element) => element.id == id);
                    deleteField(field);
                    Navigator.pop(context);
                    getField();
                  },
                ),
              ],
            ));
  }

  void addField(Field field) {
    var result = FieldRepoService().CreateField(
      field: field,
    );
    // print(result);
  }

  void editField(Field field) {
    var result = FieldRepoService().UpdateField(
      field: field,
    );
  }

  void deleteField(Field field) {
    print('object');
    var result = FieldRepoService().DeleteField(
      field: field,
    );
  }
}
