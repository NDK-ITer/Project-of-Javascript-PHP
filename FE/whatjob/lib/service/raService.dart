import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';
import 'package:whatjob/model/role.dart';

class RAService {
  static Future<http.Response> newPost(
      Map<String, dynamic> userData, String token) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseURL.baseURL}/api/ra/upload'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userData),
      );
      print(userData);

      if (response.statusCode == 200) {
        print('Upload ra successfully');
        print('Response: ${response.body}');
        return response;
      } else {
        print('Failed to Upload ra. Error: ${response.reasonPhrase}');
        throw Exception('Failed to Upload ra. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to Upload ra. Error: $e');
      throw e; // Re-throwing the error to propagate it further.
    }
  }

  static Future<List<dynamic>> fetchPublicItems() async {
    final response = await http.get(Uri.parse(
        '${BaseURL.baseURL}/api/ra/public/all')); 

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData['data'];

    } else {
      // Nếu yêu cầu thất bại, ném một ngoại lệ để xử lý sau này
      throw Exception('Failed to load items');
    }
  }
}