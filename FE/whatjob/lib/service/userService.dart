import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';
import 'package:whatjob/model/role.dart';

class UserService {
  static Future<http.Response> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseURL.baseURL}/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        print('User registered successfully');
        print('Response: ${response.body}');
        return response;
      } else {
        print('Failed to register user. Error: ${response.reasonPhrase}');
        throw Exception('Failed to register user. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to register user. Error: $e');
      throw e; // Re-throwing the error to propagate it further.
    }
  }

  static Future<http.Response> login(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseURL.baseURL}/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      print(response.body);
      return response;
    } catch (e) {
      print('Failed to login user. Error: $e');
      throw e; // Re-throwing the error to propagate it further.
    }
  }
}
