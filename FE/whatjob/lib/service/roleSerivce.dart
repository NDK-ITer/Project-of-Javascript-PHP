import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';
import 'package:whatjob/model/role.dart';

class RoleService {
  static Future<List<Role>> fetchRoles() async {
    final response = await http.get(Uri.parse('${BaseURL.baseURL}/api/all-role'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['data'];
      return data.entries
          .map((entry) => Role.fromJson(Map<String, dynamic>.from(entry.value)))
          .toList();
    } else {
      throw Exception('Failed to load roles');
    }
  }
}
