// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, dead_code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_checkbox/icon_checkbox.dart';
import 'package:web_admin/core/color.dart';

class TableWidget extends StatefulWidget {
  final String title;
  final List<List<String>> rows;
  final List<String> columns;
  const TableWidget(
      {super.key,
      required this.title,
      required this.rows,
      required this.columns});
  @override
  State<StatefulWidget> createState() {
    return _TableWidgetState();
  }
}

class _TableWidgetState extends State<TableWidget> {
  final ScrollController _scrollController = ScrollController();
  List<String> columns = [];
  List<List<String>> rows = [];
  var _loadData = true;
  double width = 1096;
  void loadWidthTable(double width) {
    setState(() {
      width = width;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      columns = widget.columns;
      rows = widget.rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadData) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              width = constraints.maxWidth;
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.neutralColor3,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    border:
                        Border.all(color: AppColors.neutralColor4, width: 1)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      height: 70,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 24, color: AppColors.neutralColor8),
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.neutralColor4,
                      height: 1,
                      thickness: 1,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 400,
                      ),
                      child: Scrollbar(
                        thickness: 5,
                        radius: Radius.circular(50),
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                if (columns.length > 0)
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: columns.length * (200 + 90),
                                    child: DataTables([
                                      'Header 1',
                                      'Header 2',
                                      'Header 3',
                                    ]),
                                  ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  bool selectAll = false;
  Widget DataTables(List<String> headers) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
          space: 0,
          thickness: 0,
          indent: 0,
          endIndent: 0,
        ),
      ),
      child: DataTable(
        dividerThickness: 0.0,
        columnSpacing: 20,
        columns: [
          DataColumn(
            label: Checkbox(
              side: MaterialStateBorderSide.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const BorderSide(
                      width: 0,
                    );
                  }
                  return const BorderSide(
                      width: 2, color: AppColors.neutralColor4);
                },
              ),
              value: selectAll,
              checkColor: AppColors.neutralColor8,
              activeColor: AppColors.primaryColor1,
              onChanged: (value) {
                setState(() {
                  selectAll = value!;
                  rows = List.generate(
                    rows.length,
                    (index) => List.generate(
                      rows[index].length,
                      (cellIndex) => cellIndex == 0
                          ? value.toString()
                          : rows[index][cellIndex],
                    ),
                  );
                });
              },
            ),
          ),
          ...List.generate(
            columns.length - 1,
            (index) => DataColumn(
                label: Text(
              columns[index + 1],
              style: TextStyle(color: AppColors.neutralColor8),
            )),
          ),
          DataColumn(label: Text('')),
        ],
        rows: List.generate(
          rows.length,
          (index) {
            return DataRow(
              cells: [
                ...List.generate(
                  rows[index].length,
                  (cellIndex) {
                    if (cellIndex == 0) {
                      return DataCell(
                        Checkbox(
                          checkColor: AppColors.neutralColor8,
                          activeColor: AppColors.primaryColor1,
                          side: MaterialStateBorderSide.resolveWith(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return const BorderSide(
                                  width: 0,
                                );
                              }
                              return const BorderSide(
                                  width: 2, color: AppColors.neutralColor4);
                            },
                          ),
                          value: rows[index][cellIndex].toString() == 'true'
                              ? true
                              : false,
                          onChanged: (value) {
                            setState(() {
                              rows[index][cellIndex] = value.toString();
                              selectAll = false;
                              // Do something when checkbox value changes
                            });
                          },
                        ),
                      );
                    } else {
                      return DataCell(
                        SizedBox(
                          width: 200,
                          child: Text(
                            rows[index][cellIndex],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColors.neutralColor8),
                          ),
                        ),
                      );
                    }
                  },
                ),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: AppColors.neutralColor8),
                      onPressed: () {
                        // Xử lý khi nhấn nút Edit
                        print('Edit button pressed for row $index');
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Xử lý khi nhấn nút Edit
                        print('Delete button pressed for row $index');
                      },
                    ),
                  ],
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}
