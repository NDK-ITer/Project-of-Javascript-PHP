import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';

class EmployerService {
  static Future<http.Response> getInfo(String? token) async {
    try {
      final response = await http.get(
        Uri.parse('${BaseURL.baseURL}/api/employer/me'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      print('Failed to get employer. Error: $e');
      throw e;
    }
  }

  static Future<http.Response> updateInfo(
      String? token, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('${BaseURL.baseURL}/api/employer/edit'),
        headers: <String, String>{
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data)
      );
      return response;
    } catch (e) {
      print('Failed to update employer. Error: $e');
      throw e;
    }
  }
}
