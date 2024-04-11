import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';

class UserService {
  static Future<void> registerUser(Map<String, dynamic> userData) async {
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
      } else {
        print('Failed to register user. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to register user. Error: $e');
    }
  }

  static Future<http.Response> login(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseURL.baseURL}/api/login'),
        headers: <String, String>{
          "Authorization": 'Bearer + aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      print(response.body);
      return response;
    } catch (e) {
      print('Failed to login user. Error: $e');
      throw e;
    }
  }
}
